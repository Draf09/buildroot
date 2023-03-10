################################################################################
#
# flac
#
################################################################################

FLAC_VERSION = 1.3.4
FLAC_SITE = http://downloads.xiph.org/releases/flac
FLAC_SOURCE = flac-$(FLAC_VERSION).tar.xz
FLAC_INSTALL_STAGING = YES
FLAC_DEPENDENCIES = $(if $(BR2_PACKAGE_LIBICONV),libiconv)
FLAC_LICENSE = Xiph BSD-like (libFLAC), GPL-2.0+ (tools), LGPL-2.1+ (other libraries)
FLAC_LICENSE_FILES = COPYING.Xiph COPYING.GPL COPYING.LGPL
FLAC_CPE_ID_VENDOR = flac_project

# patch touching configure.ac
FLAC_AUTORECONF = YES

FLAC_CONF_OPTS = \
	$(if $(BR2_INSTALL_LIBSTDCPP),--enable-cpplibs,--disable-cpplibs) \
	--disable-xmms-plugin \
	--disable-altivec \
	--disable-stack-smash-protection \
	--disable-vsx

ifeq ($(BR2_PACKAGE_LIBOGG),y)
FLAC_CONF_OPTS += --with-ogg=$(STAGING_DIR)/usr
FLAC_DEPENDENCIES += libogg
else
FLAC_CONF_OPTS += --disable-ogg
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
FLAC_DEPENDENCIES += host-nasm
FLAC_CONF_OPTS += --enable-sse
else
FLAC_CONF_OPTS += --disable-sse
endif

$(eval $(autotools-package))
