/* ****************************************************************************
* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT ShippingZonesE0.GEOGRAPHY_TYPE_NAME RES_ZONE_TYPE
,DECODE(ShippingZonesE0.POSTAL_CODE_RANGE_FLAG,'Y','Yes','No') RES_LIMIT_BY_POSTAL_CODE_RANGE
,(CASE
	WHEN ShippingZonesE0.LIMITED_BY_GEOGRAPHY_ID IS NULL THEN 
		'World'
	ELSE
		'Bounded by country'
	END) RES_SELECT_BOUNDARY
,ShippingZonesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ShippingZonesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ShippingZonesE0.CREATED_BY RSC_CREATED_BY
,ShippingZonesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHY_TYPES_VL ShippingZonesE0
WHERE ShippingZonesE0.GEOGRAPHY_USE = 'SHIPPING'
ORDER BY ShippingZonesE0.GEOGRAPHY_TYPE_NAME