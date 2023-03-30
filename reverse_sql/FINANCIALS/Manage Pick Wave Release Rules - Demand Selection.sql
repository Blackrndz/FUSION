/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=WSH_PICKING_RULES

SELECT WshPickingRules.PICKING_RULE_NAME RES_NAME
,OrgOrganizationDefinitionsPE1.ORGANIZATION_CODE RES_SHIP_FROM_ORGANIZATION
,WshPickingRules.REL_SUBINVENTORY RES_SUBINVENTORY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'WSH_BACKORDERS_FLAG'
	AND LOOKUP_CODE = WshPickingRules.BACKORDERS_ONLY_FLAG
	) RES_RELEASE_STATUS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_WSH_ORDER_LINE_TYPE'
	AND LOOKUP_CODE = WshPickingRules.SOURCE_LINE_TYPE
	) RES_ORDER_TYPE
,(SELECT NVL(SALES_ORDER_NUMBER,SOURCE_ORDER_NUMBER) 
	FROM INV_SALES_ORDERS
	WHERE SALES_ORDER_ID = WshPickingRules.ORDER_HEADER_ID
	) RES_ORDER
,PartyPEOCustomer.PARTY_NAME RES_CUSTOMER
,PartyPEOCustomer.PARTY_NUMBER RES_REGISTRY_ID
,WshPickingRules.SHIP_SET_NAME RES_SHIPMENT_SET
,(CASE
	WHEN WshPickingRules.REGION_ID IS NOT NULL THEN
		'Geography'
	WHEN WshPickingRules.ZONE_ID IS NOT NULL THEN
		'Zone'
	ELSE
		'Ship to'
	END) RES_DESTINATION_TYPE
,(SELECT(
		CASE
			WHEN(geography_element1 IS NOT NULL
			AND geography_element2  IS NOT NULL
			AND geography_element3  IS NOT NULL
			AND geography_element4  IS NOT NULL
			AND geography_element5  IS NOT NULL
			AND geography_element6  IS NOT NULL)
			THEN geography_element1 ||',' ||geography_element2 ||',' ||geography_element3 ||',' ||geography_element4 ||',' ||geography_element5 ||',' ||geography_element6
			WHEN(geography_element1 IS NOT NULL
			AND geography_element2  IS NOT NULL
			AND geography_element3  IS NOT NULL
			AND geography_element4  IS NOT NULL
			AND geography_element5  IS NOT NULL)
			THEN geography_element1 ||',' ||geography_element2 ||',' ||geography_element3 ||',' ||geography_element4 ||',' ||geography_element5
			WHEN(geography_element1 IS NOT NULL
			AND geography_element2  IS NOT NULL
			AND geography_element3  IS NOT NULL
			AND geography_element4  IS NOT NULL)
			THEN geography_element1 ||',' ||geography_element2 ||',' ||geography_element3 ||',' ||geography_element4
			WHEN(geography_element1 IS NOT NULL
			AND geography_element2  IS NOT NULL
			AND geography_element3  IS NOT NULL)
			THEN geography_element1 ||',' ||geography_element2 ||',' ||geography_element3
			WHEN(geography_element1 IS NOT NULL
			AND geography_element2  IS NOT NULL)
			THEN geography_element1 ||',' ||geography_element2
			WHEN(geography_element1 IS NOT NULL)
			THEN geography_element1
		END)
	FROM HZ_GEOGRAPHIES GeographyPEO
	WHERE GeographyPEO.GEOGRAPHY_ID = WshPickingRules.REGION_ID
	) RES_GEOGRAPHY
,(CASE
	WHEN WshPickingRules.SHIP_TO_LOCATION_ID IS NOT NULL THEN
		(SELECT PartySitesE0.PARTY_SITE_NUMBER||' - '||LocationsE0.ADDRESS1||','||LocationsE0.CITY||' , '||LocationsE0.STATE||', '||LocationsE0.POSTAL_CODE||','||LocationsE0.COUNTRY
		--hz_format_pub.format_address(p_location_id => LocationsE0.LOCATION_ID, p_line_break => ',') 
		FROM HZ_LOCATIONS LocationsE0
		,HZ_PARTY_SITES PartySitesE0
		WHERE PartySitesE0.LOCATION_ID = LocationsE0.LOCATION_ID
		AND LocationsE0.LOCATION_ID = WshPickingRules.SHIP_TO_LOCATION_ID
		AND PartySitesE0.PARTY_ID = SHIP_TO_PARTY_ID)
	END) RES_SHIP_TO_LOCATION
,(SELECT GeographyPEO.GEOGRAPHY_NAME
	FROM HZ_GEOGRAPHIES GeographyPEO
	WHERE GeographyPEO.GEOGRAPHY_USE = 'SHIPPING'
	AND GeographyPEO.GEOGRAPHY_ID = WshPickingRules.ZONE_ID
	) RES_ZONE
,DECODE(WshPickingRules.EXISTING_RSVS_ONLY_FLAG,'Y','Yes','No') RES_PRIOR_RESERVATIONS_ONLY
,(CASE
	WHEN WshPickingRules.SCH_START_DAYS IS NULL THEN
		'Start on'
	ELSE
		'Start within'
	END) RES_SCHEDULED_SHIP_START_DATE_
,TO_CHAR(WshPickingRules.FROM_SCHEDULED_SHIP_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_SCHEDULED_SHIP_START_DAT_0
,WshPickingRules.SCH_START_DAYS RES_SCHEDULED_SHIP_START_DAT_1
,TO_CHAR(TO_DATE('1970-01-01 00','yyyy-mm-dd hh24') +WshPickingRules.SCH_START_HOURS/60/60/24 , 'HH24:MI:SS') RES_SCHEDULED_SHIP_START_DAT_2
,(CASE
	WHEN WshPickingRules.SCH_END_DAYS IS NULL THEN
		'End on'
	ELSE
		'End within'
	END) RES_SCHEDULED_SHIP_END_DATE_OP
,TO_CHAR(WshPickingRules.TO_SCHEDULED_SHIP_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_SCHEDULED_SHIP_END_DATE_DA
,WshPickingRules.SCH_END_DAYS RES_SCHEDULED_SHIP_END_DATE__3
,TO_CHAR(TO_DATE('1970-01-01 00','yyyy-mm-dd hh24') +WshPickingRules.SCH_END_HOURS/60/60/24 , 'HH24:MI:SS') RES_SCHEDULED_SHIP_END_DATE_TI
,(CASE
	WHEN WshPickingRules.REQ_START_DAYS IS NULL THEN
		'Start on'
	ELSE
		'Start within'
	END) RES_REQUESTED_START_DATE_OPTIO
,TO_CHAR(WshPickingRules.FROM_REQUESTED_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_REQUESTED_START_DATE_DATET
,WshPickingRules.REQ_START_DAYS RES_REQUESTED_START_DATE_DAYS
,TO_CHAR(TO_DATE('1970-01-01 00','yyyy-mm-dd hh24') +WshPickingRules.REQ_START_HOURS/60/60/24 , 'HH24:MI:SS') RES_REQUESTED_START_DATE_TIME
,(CASE
	WHEN WshPickingRules.TO_REQUESTED_DATE IS NULL THEN
		'End on'
	ELSE
		'End within'
	END) RES_REQUESTED_END_DATE_OPTIONS
,TO_CHAR(WshPickingRules.TO_REQUESTED_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_REQUESTED_END_DATE_DATETIM
,WshPickingRules.REQ_END_DAYS RES_REQUESTED_END_DATE_DAYS
,TO_CHAR(TO_DATE('1970-01-01 00','yyyy-mm-dd hh24') +WshPickingRules.REQ_END_HOURS/60/60/24 , 'HH24:MI:SS') RES_REQUESTED_END_DATE_TIME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'WSH_SHIPPING_PRIORITY'
	AND LOOKUP_CODE = WshPickingRules.SHIPMENT_PRIORITY_CODE
	) RES_SHIPPING_PRIORITY
,(SELECT DISTINCT (PartyPEO.PARTY_NAME||'-'||ModeOfTransportPEO.MEANING||'-'||ServiceLevelPEO.MEANING) AS ShipMethod
	FROM WSH_ORG_CARRIER_SERVICES WarehouseCarrierServicePEO
	,RCS_LOOKUPS ModeOfTransportPEO
	,RCS_LOOKUPS ServiceLevelPEO
	,HZ_PARTIES PartyPEO
	,WSH_CARRIERS CarrierPEO
	WHERE(WarehouseCarrierServicePEO.CARRIER_ID      = PartyPEO.PARTY_ID)
	AND(WarehouseCarrierServicePEO.MODE_OF_TRANSPORT = ModeOfTransportPEO.LOOKUP_CODE)
	AND(ModeOfTransportPEO.LOOKUP_TYPE               = 'WSH_MODE_OF_TRANSPORT')
	AND(WarehouseCarrierServicePEO.SERVICE_LEVEL     = ServiceLevelPEO.LOOKUP_CODE)
	AND(ServiceLevelPEO.LOOKUP_TYPE                  = 'WSH_SERVICE_LEVELS')
	AND(CarrierPEO.CARRIER_ID                        = WarehouseCarrierServicePEO.CARRIER_ID)
	AND(CarrierPEO.CARRIER_ID                        = PartyPEO.PARTY_ID)
	AND WarehouseCarrierServicePEO.SHIP_METHOD_CODE = WshPickingRules.SHIP_METHOD_CODE
	)RES_SHIPPING_METHOD
,DECODE(WshPickingRules.INCLUDE_PLANNED_LINES,'Y','Yes','No') RES_INCLUDE_ASSIGNED_LINES
,WshPickingRules.TP_SHIPMENT_NUMBER RES_TRANSPORTATION_SHIPMENT
,WshPickingRules.TP_INITIAL_LEG_DEST_LOC_ID RES_INITIAL_DESTINATION
,CatalogPEO.CATEGORY_SET_NAME RES_CATALOG_NAME
,CategoryPEO.CATEGORY_NAME RES_CATEGORY_NAME
,ItemPEO.ITEM_NUMBER RES_ITEM
,ItemPEO.DESCRIPTION RES_ITEM_DESCRIPTION
,WshPickingRules.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshPickingRules.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshPickingRules.CREATED_BY RSC_CREATED_BY
,WshPickingRules.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,WshPickingRules.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_PICKING_RULES WshPickingRules
,INV_ORGANIZATION_DEFINITIONS_V OrgOrganizationDefinitionsPE1
,EGP_CATEGORY_SETS_VL CatalogPEO
,EGP_CATEGORIES_VL CategoryPEO
,EGP_SYSTEM_ITEMS_VL ItemPEO
,HZ_PARTIES PartyPEOCustomer
WHERE WshPickingRules.ORGANIZATION_ID = OrgOrganizationDefinitionsPE1.ORGANIZATION_ID(+)
AND WshPickingRules.CATEGORY_SET_ID              = CatalogPEO.CATEGORY_SET_ID(+)
AND WshPickingRules.CATEGORY_ID                  = CategoryPEO.CATEGORY_ID(+)
AND WshPickingRules.INVENTORY_ITEM_ID           = ItemPEO.INVENTORY_ITEM_ID(+)
AND WshPickingRules.SHIP_TO_PARTY_ID             = PartyPEOCustomer.PARTY_ID (+)
ORDER BY WshPickingRules.PICKING_RULE_NAME