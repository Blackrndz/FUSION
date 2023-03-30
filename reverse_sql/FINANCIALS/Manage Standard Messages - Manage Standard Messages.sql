/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Standard%20Messages%20-%20Manage%20Standard%20Messages.sql $:
 * $Id: Manage Standard Messages - Manage Standard Messages.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select ARSTANDARDTEXTVL.name RES_NAME
,AR_LOOKUPS.MEANING  RES_TYPE
,TO_CHAR(ARSTANDARDTEXTVL.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(ARSTANDARDTEXTVL.END_DATE,'DD-Mon-YYYY') RES_TO_DATE
,ARSTANDARDTEXTVL.TEXT RES_MESSAGE
,ARSTANDARDTEXTVL.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ARSTANDARDTEXTVL.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ARSTANDARDTEXTVL.CREATED_BY  RSC_CREATED_BY
,ARSTANDARDTEXTVL.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from AR_STANDARD_TEXT ARSTANDARDTEXTVL 
,AR_LOOKUPS 
where ARSTANDARDTEXTVL.TEXT_USE_TYPE = AR_LOOKUPS.LOOKUP_CODE
and AR_LOOKUPS.LOOKUP_TYPE = 'STANDARD_MSG_TYPES'