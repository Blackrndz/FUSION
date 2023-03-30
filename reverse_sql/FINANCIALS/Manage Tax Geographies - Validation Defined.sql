/* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT countriesE0.GEOGRAPHY_NAME RES_COUNTRY_NAME
,NVL((SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'HZ_ADDRESS_VALIDATION_LEVEL'
	AND LOOKUP_CODE = validatesE0.ADDR_VAL_LEVEL 
	),'None') RES_GEOGRAPHY_VALIDATION_LEVEL
,validatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,validatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,validatesE0.CREATED_BY RSC_CREATED_BY
,validatesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHIES countriesE0
,HZ_GEO_STRUCTURE_LEVELS validatesE0
WHERE countriesE0.GEOGRAPHY_TYPE = 'COUNTRY'
AND countriesE0.COUNTRY_CODE = validatesE0.COUNTRY_CODE
AND validatesE0.PARENT_GEOGRAPHY_TYPE = 'COUNTRY'
ORDER BY countriesE0.GEOGRAPHY_NAME