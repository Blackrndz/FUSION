/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contract%20Types%20-%20Additional%20Party%20Roles.sql $:
 * $Id: Manage Contract Types - Additional Party Roles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT okcContactTPYEsEO.NAME  RES_NAME
,DECODE(okcContactTPYEsEO.INTER_COMPANY_FLAG,'Y','Yes','No') RES_INTERCOMPANY
,DECODE(okcContactTPYEsEO.INTER_PROJECT_FLAG,'Y','Yes','No') RES_INTERPROJECT
,DECODE(okcContactTPYEsEO.ENABLE_BILLING_CTRL_FLAG,'Y','Yes','No') RES_ENABLE_BILLING_CONTROLS
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = BILLING_LIMIT_TYPE 
	AND LOOKUP_TYPE = 'OKC_BILLING_LIMIT_TYPE' AND LANGUAGE = USERENV('LANG')) RES_BILLING_LIMIT_TYPE
,okcContactTPYEsEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,okcContactTPYEsEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,okcContactTPYEsEO.CREATED_BY RSC_CREATED_BY
,okcContactTPYEsEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_CONTRACT_TYPES_VL okcContactTPYEsEO
ORDER BY okcContactTPYEsEO.NAME


