/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_CC_DOWNLOAD_PARAMS

SELECT ExmCardProgramsE0.CARD_PROGRAM_NAME RES_NAME
,ExmCcDownloadParams.DOWNLOAD_PROFILE_NAME RES_DOWNLOAD_PROFILE_NAME
,ExmCcDownloadParams.USERNAME RES_ACCOUNT_NAME
,EXM_DOWNLOAD_UTILS.DECRYPT(ExmCcDownloadParams.ENCRYPTED_PASSWORD) RES_ACCOUNT_PASSWORD
,ExmCcDownloadParams.REMOTE_FILENAME RES_FILE_NAME_PREFIX
,ExmCcDownloadParams.SERVER RES_SERVER
,NULL RES_ENCRYPTION_KEY_ALIAS
,ExmCcDownloadParams.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ExmCcDownloadParams.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ExmCcDownloadParams.CREATED_BY  RSC_CREATED_BY
,ExmCcDownloadParams.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_CARD_PROGRAMS ExmCardProgramsE0
,EXM_CC_DOWNLOAD_PARAMS ExmCcDownloadParams
WHERE ExmCardProgramsE0.CARD_PROGRAM_ID = ExmCcDownloadParams.CARD_PROGRAM_ID
ORDER BY ExmCardProgramsE0.CARD_PROGRAM_NAME