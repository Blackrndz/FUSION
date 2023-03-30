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
,dependentsE0.NAME RES_DEPENDENT_FIELD_NAME
,(SELECT DISPLAY_NAME
    FROM HWM_TM_ATRB_FLDS_VL
    WHERE TM_ATRB_FLD_ID = dependentsE0.TCLAYFLD_ATTRIBUTE_NUMBER13
    ) RES_INDEPENDENT_TIME_ATTRIBUTE
,dependentTmE0.DISPLAY_NAME RES_DEPENDENT_TIME_ATTRIBUTE
,DECODE(dependentTmE0.CLASS,'DETAIL_INSTANCE','Detailed','GLOBAL_DETAIL','General') RES_LEVEL
,(CASE
	WHEN dependentTmE0.CLASS = 'DETAIL_INSTANCE' THEN
		(SELECT DISPLAY_NAME
			FROM HWM_TM_ATRB_FLDS_VL
			WHERE TM_ATRB_FLD_ID = dependentTmE0.PARENT_TM_ATRB_FLD_ID)
	END) RES_PARENT_ATTRIBUTE_VALUE
,dependentsE0.DESCRIPTION RES_DESCRIPTION
,(CASE
	WHEN EXISTS (SELECT 1 FROM HXT_TCLAYFLD_CXT_DEPT WHERE TCLAYFLD_DEFNS_ID = dependentsE0.TCLAYFLD_DEFNS_ID) THEN 
		'For specific independent time attribute values'
	ELSE
		'For all independent time attribute values'
	END) RES_AVAILABILITY
--,DECODE(dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR25,'Y','For specific independent time attribute values','N','For all independent time attribute values') RES_AVAILABILITY
,(SELECT DISPLAY_NAME
    FROM HWM_DATA_SOURCE_USAGES dsUsage
    ,HWM_DATA_SOURCES_VL dsE0
    WHERE dsE0.DATA_SOURCE_ID = dsUsage.DATA_SOURCE_ID
    AND dsUsage.DATA_SOURCE_USAGE_ID = dependentsE0.TCLAYFLD_ATTRIBUTE_NUMBER2
    ) RES_FILTERED_DATA_SOURCE_FOR_T
,(SELECT DISPLAY_NAME
    FROM HWM_DATA_SOURCE_USAGES dsUsage
    ,HWM_DATA_SOURCES_VL dsE0
    WHERE dsE0.DATA_SOURCE_ID = dsUsage.DATA_SOURCE_ID
    AND dsUsage.DATA_SOURCE_USAGE_ID = dependentsE0.TCLAYFLD_ATTRIBUTE_NUMBER18
    ) RES_UNFILTERED_DATA_SOURCE_FOR
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LOOKUP_TYPE = 'HXT_TCFIELD_AUTOPOP_TYPES'
    AND LOOKUP_CODE = dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR2
    AND LANGUAGE = USERENV('LANG')
    ) RES_POPULATION_METHOD_FOR_NEW_
,dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR23 RES_SPECIFIC_DISPLAY_VALUE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LOOKUP_TYPE = 'HXT_TCFIELD_NEWENTRY_FUNC'
    AND LOOKUP_CODE = dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR24
    AND LANGUAGE = USERENV('LANG')
    ) RES_FUNCTION
/*,(SELECT DISPLAY_NAME
    FROM HWM_TM_ATRB_FLDS_VL
    WHERE TM_ATRB_FLD_ID = dependentsE0.TCLAYFLD_ATTRIBUTE_NUMBER16
	) RES_TIME_ATTRIBUTE_PARAMETER_F*/
,DECODE(dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR3,'LISTOFVALUES','Smart choice list'
	,'TEXTBOX','Text box'
	,'HXT_BUTTON',''
	,'READONLY','Read-Only'
	,'HIDDEN','Hidden'
	,'DATE','Date') RES_DISPLAY_TYPE
,dependentsE0.LABEL RES_DISPLAY_NAME
,DECODE(dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR4,'Y','Yes','No') RES_ENABLE_OVERRIDE_ON_LAYOUTS
,DECODE(dependentsE0.TCLAYFLD_ATTRIBUTE_CHAR22,'Y','Yes','N','No') RES_REQUIRED_ON_THE_WEB_CLOCK
,dependentsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,dependentsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,dependentsE0.CREATED_BY RSC_CREATED_BY
,dependentsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
,(SELECT * FROM HXT_TCLAYFLD_DEFNS_VL WHERE TCLAY_ID IS NULL) dependentsE0
,HWM_TM_ATRB_FLDS_VL dependentTmE0
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_DEFNS_ID = dependentsE0.P_TCLAYFLD_DEFNS_ID
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'W'
AND dependentsE0.TCLAYFLD_ATTRIBUTE_NUMBER1 = dependentTmE0.TM_ATRB_FLD_ID(+)
ORDER BY layoutCompsE0.NAME