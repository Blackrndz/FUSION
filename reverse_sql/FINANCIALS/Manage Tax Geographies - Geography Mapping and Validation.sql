/* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT countriesE0.GEOGRAPHY_NAME RES_COUNTRY_NAME
,NVL((SELECT STYLE_FORMAT_NAME
	FROM HZ_STYLE_FORMATS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND STYLE_FORMAT_CODE = addressesE0.ADDRESS_STYLE 
	),'No Styles Format') RES_ADDRESS_STYLE_FORMAT
,(SELECT GEOGRAPHY_TYPE_NAME
	FROM HZ_GEOGRAPHY_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND GEOGRAPHY_TYPE = addrAttrsE0.GEOGRAPHY_TYPE 
	) RES_GEOGRAPHY_TYPE
,DECODE(addrAttrsE0.LOC_COMPONENT
	,'ADDL_ADDRESS_ATTRIBUTE1','Additional address attribute 1'
	,'ADDL_ADDRESS_ATTRIBUTE2','Additional address attribute 2'
	,'ADDL_ADDRESS_ATTRIBUTE3','Additional address attribute 3'
	,'ADDL_ADDRESS_ATTRIBUTE4','Additional address attribute 4'
	,'ADDL_ADDRESS_ATTRIBUTE5','Additional address attribute 5'
	,'REGION_1','County'
	,'REGION_2','Province'
	,'REGION_3','State'
	,'TOWN_OR_CITY','City'
	,'POSTAL_CODE','Postal code'
	) RES_MAP_TO_ATTRIBUTE
,DECODE(addrAttrsE0.ENABLE_LOV_FLAG,'Y','Yes','No') RES_ENABLE_LIST_OF_VALUES
,(CASE
	WHEN EXISTS (SELECT 1
		FROM HZ_ADDRESS_USAGES usages
		,HZ_ADDRESS_USAGE_DTLS usageDtls
		WHERE usages.USAGE_CODE = 'TAX'
		AND usages.USAGE_ID = usageDtls.USAGE_ID
		AND usages.MAP_ID = addrAttrsE0.MAP_ID
		AND usageDtls.GEOGRAPHY_TYPE = addrAttrsE0.GEOGRAPHY_TYPE) THEN
		'Yes'
	ELSE
		'No'
	END) RES_TAX_VALIDATION
,(CASE
	WHEN EXISTS (SELECT 1
		FROM HZ_ADDRESS_USAGES usages
		,HZ_ADDRESS_USAGE_DTLS usageDtls
		WHERE usages.USAGE_CODE = 'GEOGRAPHY'
		AND usages.USAGE_ID = usageDtls.USAGE_ID
		AND usages.MAP_ID = addrAttrsE0.MAP_ID
		AND usageDtls.GEOGRAPHY_TYPE = addrAttrsE0.GEOGRAPHY_TYPE) THEN
		'Yes'
	ELSE
		'No'
	END) RES_GEOGRAPHY_VALIDATION
,addrAttrsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,addrAttrsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,addrAttrsE0.CREATED_BY RSC_CREATED_BY
,addrAttrsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHIES countriesE0
,HZ_GEO_STRUCT_MAP addressesE0
,HZ_GEO_STRUCT_MAP_DTL addrAttrsE0
WHERE countriesE0.GEOGRAPHY_TYPE = 'COUNTRY'
AND countriesE0.COUNTRY_CODE = addressesE0.COUNTRY_CODE
AND addressesE0.LOC_TBL_NAME = 'PER_ADDRESSES_F'
AND addressesE0.MAP_ID = addrAttrsE0.MAP_ID
AND addrAttrsE0.GEOGRAPHY_TYPE != 'COUNTRY'
ORDER BY countriesE0.GEOGRAPHY_NAME
,addressesE0.ADDRESS_STYLE 
,addrAttrsE0.LOC_SEQ_NUM