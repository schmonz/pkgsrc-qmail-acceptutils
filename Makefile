# $NetBSD: Makefile,v 1.2 2018/10/24 13:18:54 schmonz Exp $

DISTNAME=		netqmail-1.06
PKGNAME=		qmail-acceptutils-${ACPATCHVERSION}
PKGREVISION=		1
CATEGORIES=		mail
MASTER_SITES=		http://www.qmail.org/

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		https://schmonz.com/qmail/acceptutils/
COMMENT=		Offer SMTP AUTH with new features and no patch conflicts
LICENSE=		public-domain

ACPATCHVERSION=		20181022
ACPATCH=		${DISTNAME}-acceptutils-${ACPATCHVERSION}.patch
PATCHFILES+=		${ACPATCH}
SITES.${ACPATCH}=	${HOMEPAGE}

DEPENDS+=		stunnel-[0-9]*:../../security/stunnel

CONFLICTS+=		qmail<=1.03nb32

DJB_RESTRICTED=		no
BUILD_TARGET=		acceptutils

ACCEPTUTILS=		authup checknotroot fixsmtpio reup

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man8

do-install:
	for i in ${ACCEPTUTILS}; do					\
		${INSTALL_PROGRAM} ${WRKSRC}/$$i ${DESTDIR}${PREFIX}/bin/$$i; \
		${INSTALL_MAN} ${WRKSRC}/$$i.8 ${DESTDIR}${PREFIX}/${PKGMANDIR}/man8/$$i.8; \
	done

.include "../../mk/djbware.mk"
.include "../../mk/bsd.pkg.mk"
