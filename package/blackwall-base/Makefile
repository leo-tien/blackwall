#
# Copyright (C) 2020 Blackwall
#

include $(TOPDIR)/rules.mk

PKG_NAME:=blackwall-base
PKG_VERSION=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=Blackwall
	CATEGORY:=Blackwall
	MAINTAINER:=leo
	TITLE:=Blackwall base files
	PKGARCH:=all
	DEPENDS:=+base-files +mailsend
endef

define Package/$(PKG_NAME)/config
endef

define Package/$(PKG_NAME)/description
endef

define Build/Configure
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	@echo -en "\e[32mInstalling $(PKG_NAME)\n\e[0m"
	#$(CP) ./files/* $(1)/
	$(CP) ./files $(TOPDIR)/.
endef

$(eval $(call BuildPackage,blackwall-base))

