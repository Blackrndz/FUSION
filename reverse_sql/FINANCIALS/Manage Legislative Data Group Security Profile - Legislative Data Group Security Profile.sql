/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ldgSecPflsE0.NAME RES_NAME
,DECODE(ldgSecPflsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(ldgSecPflsE0.VIEW_ALL,'Y','Yes','No') RES_VIEW_ALL
,ldgSecPflsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ldgSecPflsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ldgSecPflsE0.CREATED_BY RSC_CREATED_BY
,ldgSecPflsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_LDG_SECURITY_PROFILES ldgSecPflsE0
ORDER BY ldgSecPflsE0.NAME