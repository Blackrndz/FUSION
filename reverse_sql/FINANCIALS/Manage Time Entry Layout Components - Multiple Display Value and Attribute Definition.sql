/* ****************************************************************************
 * $Revision: 59704 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-22 17:48:05 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19.01/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 59704 2016-11-22 10:48:05Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HWM_TE_ALT_NAME_VALS_VL

SELECT layoutCompsE0.NAME RES_NAME
,teNameValsE0.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,teNameValsE0.ALT_NAME_VALUE RES_DISPLAY_VALUE
,DECODE(teNameValsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ORA_HWM_MTCF_ACTIONS'
	AND LOOKUP_CODE = teNameValsE0.WORKER_ACTION_CD
	) RES_WORKER_ALLOWED_ACTION
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ORA_HWM_MTCF_ACTIONS'
	AND LOOKUP_CODE = teNameValsE0.MANAGER_ACTION_CD 
	) RES_MANAGER_ALLOWED_ACTION
,teNameValsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,teNameValsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,teNameValsE0.CREATED_BY RSC_CREATED_BY
,teNameValsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
,HWM_TE_ALT_NAME_VALS_VL teNameValsE0
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'M'
AND layoutCompsE0.P_TCLAYFLD_DEFNS_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_NUMBER1 = teNameValsE0.TE_ALT_NAME_ID
ORDER BY layoutCompsE0.NAME
,teNameValsE0.DISPLAY_SEQUENCE