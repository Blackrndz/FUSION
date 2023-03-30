/* ****************************************************************************
 * $Revision: 59704 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-22 17:48:05 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19.01/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 59704 2016-11-22 10:48:05Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LOOKUP_TYPE = 'HXT_TCFIELD_TYPES'
    AND LOOKUP_CODE = layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1
    AND LANGUAGE = USERENV('LANG')
    ) RES_LAYOUT_COMPONENT_TYPE
,layoutCompsE0.NAME RES_NAME
,layoutCompsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LOOKUP_TYPE = 'HXT_TCFIELD_AUTOPOP_TYPES'
    AND LOOKUP_CODE = layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR2
    AND LANGUAGE = USERENV('LANG')
    ) RES_POPULATION_METHOD_FOR_NEW_
,layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR23 RES_SPECIFIC_DISPLAY_VALUE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LOOKUP_TYPE = 'HXT_TCFIELD_NEWENTRY_FUNC'
    AND LOOKUP_CODE = layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR24
    AND LANGUAGE = USERENV('LANG')
    ) RES_FUNCTION
,DECODE(layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR3,'LISTOFVALUES','Smart choice list'
	,'TEXTBOX','Text box'
	,'HXT_BUTTON',''
	,'READONLY','Read-Only'
	,'HIDDEN','Hidden'
	,'DATE','Date') RES_DISPLAY_TYPE
,layoutCompsE0.LABEL RES_DISPLAY_NAME
,DECODE(layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR4,'Y','Yes','No') RES_ENABLE_OVERRIDE_ON_LAYOUTS
,DECODE(layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR22,'Y','Yes','N','No') RES_REQUIRED_ON_THE_TIME_CARD
,layoutCompsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,layoutCompsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,layoutCompsE0.CREATED_BY RSC_CREATED_BY
,layoutCompsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'M'
AND layoutCompsE0.P_TCLAYFLD_DEFNS_ID IS NULL
ORDER BY layoutCompsE0.NAME