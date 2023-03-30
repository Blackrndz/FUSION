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
,addressesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,addressesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,addressesE0.CREATED_BY RSC_CREATED_BY
,addressesE0.CREATION_DATE RSC_CREATION_DATE
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
WHERE countriesE0.GEOGRAPHY_TYPE = 'COUNTRY'
AND countriesE0.COUNTRY_CODE = addressesE0.COUNTRY_CODE
AND addressesE0.LOC_TBL_NAME = 'PER_ADDRESSES_F'
ORDER BY countriesE0.GEOGRAPHY_NAME
,addressesE0.ADDRESS_STYLE 