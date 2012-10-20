#!/bin/bash
# CFEngine Community/Enterprise Vagrant Install Provisioner

# Default Community Version
DEFAULT_COMMUNITY_VERSION="3.3.5-1"

# Default Enterprise Version
DEFAULT_ENTERPRISE_VERSION="2.2.3-1"

# Don't actually install if DRYRUN is true
if [[ -z "$DRYRUN" ]]; then
    DRYRUN=false
fi

# Default package location, you can export PKGDIR before running 
# the script to override.
# The PKGDIR variable should be the location of the 
# packages *IN THE VM* - the directory where the Vagrantfile resides
# is mapped to /vagrant in the VM, so you should keep
# this mapping into account.
if [[ -z "$PKGDIR" ]]; then
    PKGDIR=/vagrant/packages
fi

# Dist is "enterprise" or "community" (actually anything other
# than "enterprise" is considered as community)
DIST=$1

# Type is "hub" or "client" (actually anything other
# than "hub" is considered as a client)
if [[ -n "$2" ]]; then
   TYPE="client"
else
  TYPE=$2
fi

# Version is the version of the package to install
# Example: 3.3.5-1, 2.2.2
VERSION=$3

# Detect the arch, 
ARCH=$(uname -i)
   
function usage {
  echo "Usage: $0 [distribution] [type] [version]"
  echo "       distribution     enterprise|community*"
  echo "       type             hub|client*"
  exit 1
}

# Determine how to install CFEngine
function install_cfengine {

    if [[ -f /etc/redhat-release ]]; then
        PKGTYPE="rpm"
        echo "I have detected a redhat style system, using rpm"

    elif [[ -f /etc/debian_version ]]; then
        PKGTYPE="deb"
        echo "I have detected a debian style system, using dpkg" 
        echo 

    else
        echo "I was unable to determine the system type, currently I support debian and redhat style systems"
        exit 1
    fi


    # Install CFEngine
    if [[ "$DIST" == "enterprise" ]]; then
        install_cfengine_enterprise
    else
        install_cfengine_community
    fi 
}

function install_cfengine_community {

    if [ -z "$VERSION" ]; then
        VERSION=$DEFAULT_COMMUNITY_VERSION
    fi

    # Non x86_64 versions of CFEngine Enterprise are named with i686
    # This differs from enterprise which is i686
    if [[ "$ARCH" != "x86_64" ]]; then
        ARCH="i386"
    fi

    # For RPM/yum
    if [[ "$PKGTYPE" == "rpm" ]]; then 
      CMD="rpm -i"
      PKG1="$PKGDIR"/cfengine-community-"$VERSION"."$ARCH"."$PKGTYPE"

    # For Ubuntu/apt
    elif [[ "$PKGTYPE" == "deb" ]]; then 
      CMD="dpkg --install"
        # The debian x86_64 packages are named amd64
        if [[ "$ARCH" == "x86_64" ]]; then
            ARCH="amd64"
        fi
      PKG1="$PKGDIR"/cfengine-community_"$VERSION"_"$ARCH"."$PKGTYPE"

    # For UNKNOWN
    else
        echo "I did not recognize the package type $PKGTYPE"
        exit 1
    fi

    # Install the base Enterprise package
    install_pkg $PKG1



}
function install_cfengine_enterprise {

    if [ -z "$VERSION" ]; then
        VERSION=$DEFAULT_ENTERPRISE_VERSION
    fi

    # Non x86_64 versions of CFEngine Enterprise are named with i686
    # This differs from community which is i386
    if [[ "$ARCH" != "x86_64" ]]; then
        ARCH="i686"
    fi

    # For RPM/yum
    if [[ "$PKGTYPE" == "rpm" ]]; then 
      CMD="rpm -ivh"
      PKG1="$PKGDIR"/cfengine-nova-"$VERSION"."$ARCH"."$PKGTYPE"
      PKG2="$PKGDIR"/cfengine-nova-expansion-"$VERSION"."$ARCH"."$PKGTYPE"

    # For Ubuntu/apt
    elif [[ "$PKGTYPE" == "deb" ]]; then 
      CMD="dpkg --install"
      PKG1="$PKGDIR"/cfengine-nova_"$VERSION"_"$ARCH"."$PKGTYPE"
      PKG2="$PKGDIR"/cfengine-nova-expansion_"$VERSION"_"$ARCH"."$PKGTYPE"

    # For UNKNOWN
    else
        echo "I did not recognize the package type $PKGTYPE"
        exit 1
    fi

    # Install the base Enterprise package
    install_pkg $PKG1

    # Install the expansion pack on the hub only
    if [[ "$TYPE" == "hub" ]]; then
        install_pkg $PKG2
    fi
}

function install_pkg {
    PKG=$1
    if [[ -f "$PKG" ]]; then
        if "$DRYRUN"; then
            echo $CMD $PKG
        else
            echo "Installing $PKG"
            $CMD $PKG 
        fi
    else
        echo "I was unable to find $PKG please download the package from"
        echo "https://cfengine.com/downloads and place it in your PKGDIR $PKGDIR"
        exit 1
    fi
}


# If /var/cfengine exists, do nothing, assume it's installed already
if [[ -d /var/cfengine ]]
then
  if "$DRYRUN"; then
      echo "I found CFEngine installed already, but since we are just pretending anyway I'll continue"
  else
    exit 0
  fi
fi

# Distribution is a required argument 
[[ -n "$1" ]] || usage

install_cfengine


