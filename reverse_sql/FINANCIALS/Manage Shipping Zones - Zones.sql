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
,(CASE
	WHEN ShippingZonesE0.LIMITED_BY_GEOGRAPHY_ID IS NULL THEN 
		'World'
	ELSE
		'Bounded by country'
	END) RES_SELECT_BOUNDARY
,GeographiesE0.GEOGRAPHY_NAME RES_NAME
,GeographiesE0.GEOGRAPHY_CODE RES_CODE
,GeographiesE0.TIMEZONE_CODE RES_TIME_ZONE
,TO_CHAR(GeographiesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(GeographiesE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,GeographiesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GeographiesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GeographiesE0.CREATED_BY RSC_CREATED_BY
,GeographiesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHY_TYPES_VL ShippingZonesE0
,HZ_GEOGRAPHIES GeographiesE0
WHERE ShippingZonesE0.GEOGRAPHY_USE = 'SHIPPING'
AND ShippingZonesE0.GEOGRAPHY_TYPE = GeographiesE0.GEOGRAPHY_TYPE
AND ShippingZonesE0.GEOGRAPHY_USE = GeographiesE0.GEOGRAPHY_USE
ORDER BY ShippingZonesE0.GEOGRAPHY_TYPE_NAME
,GeographiesE0.GEOGRAPHY_NAME