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
,teNameValsE0.ALT_NAME_VALUE RES_DISPLAY_VALUE
,(SELECT GROUP_NAME
	FROM HWM_GRPS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND GRP_ID = altNameGrpsE0.GRP_ID 
	) RES_GROUP
,TO_CHAR(altNameGrpsE0.START_DATE,'DD-Mon-YYYY') RES_FROM
,TO_CHAR(altNameGrpsE0.END_DATE,'DD-Mon-YYYY') RES_TO
,altNameGrpsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,altNameGrpsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,altNameGrpsE0.CREATED_BY RSC_CREATED_BY
,altNameGrpsE0.CREATION_DATE RSC_CREATION_DATE
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
,HWM_TE_ALT_NAME_GRPS altNameGrpsE0
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'M'
AND layoutCompsE0.P_TCLAYFLD_DEFNS_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_NUMBER1 = teNameValsE0.TE_ALT_NAME_ID
AND teNameValsE0.TE_ALT_NAME_VAL_ID  = altNameGrpsE0.TE_ALT_NAME_VAL_ID 
ORDER BY layoutCompsE0.NAME
,teNameValsE0.DISPLAY_SEQUENCE
,3