/* ****************************************************************************
 * $Revision: 59704 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-22 17:48:05 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19.01/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 59704 2016-11-22 10:48:05Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT layoutCompsE0.NAME RES_NAME
,setCmpsE0.SEQUENCE RES_ATTRIBUTE_DISPLAY_SEQUENCE
,(SELECT DISPLAY_NAME 
		FROM HWM_TM_ATRB_FLDS_VL 
		WHERE TM_ATRB_FLD_ID = setCmpsE0.TM_ATRB_FLD_ID
		) RES_TIME_ATTRIBUTE
,(SELECT DISPLAY_NAME
    FROM HWM_DATA_SOURCE_USAGES dsUsage
    ,HWM_DATA_SOURCES_VL dsE0
    WHERE dsE0.DATA_SOURCE_ID = dsUsage.DATA_SOURCE_ID
    AND dsUsage.DATA_SOURCE_USAGE_ID = setCmpsE0.DATA_SOURCE_USAGE_ID 
	 ) RES_UNFILTERED_DATA_SOURCE_FOR
,'' RES_DEPENDENT_ON_TIME_ATTRIBUT
,DECODE(setCmpsE0.REQUIRED_FLAG,'false','No','Yes') RES_REQUIRED_FOR_ATTRIBUTE_DEF
,setCmpsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,setCmpsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,setCmpsE0.CREATED_BY RSC_CREATED_BY
,setCmpsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
,HWM_TE_ALT_NAMES teNamesE0
,HWM_TM_ATRB_FLD_SET_CMPS setCmpsE0
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'W'
AND layoutCompsE0.P_TCLAYFLD_DEFNS_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_NUMBER1 = teNamesE0.TE_ALT_NAME_ID
AND teNamesE0.TM_ATRB_FLD_SET_ID = setCmpsE0.TM_ATRB_FLD_SET_ID
ORDER BY layoutCompsE0.NAME
,setCmpsE0.SEQUENCE