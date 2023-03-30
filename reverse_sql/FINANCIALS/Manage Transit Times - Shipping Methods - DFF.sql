/* ****************************************************************************
* $Revision: 79377 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-09-21 18:00:34 +0700 (Wed, 21 Sep 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transit%20Times%20-%20Shipping%20Methods%20-%20DFF.sql $:
* $Id: Manage Transit Times - Shipping Methods - DFF.sql 79377 2022-09-21 11:00:34Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=WSH_TRANSIT_TIMES


-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10108##RES##WSH_TRANSIT_TIME_VALUES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT
(CASE WHEN ORIGIN_TYPE = 'LE'
	THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'WSH_ORG_DEST_TYPE'
			AND LOOKUP_CODE = WshTransitTimes.ORIGIN_EXT_LOC_SOURCE)
	ELSE
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'WSH_ORG_DEST_TYPE'
			AND LOOKUP_CODE = WshTransitTimes.ORIGIN_TYPE)
	END) RES_ORIGIN_TYPE
,(CASE WHEN WshTransitTimes.ORIGIN_TYPE = 'LI'
	THEN (SELECT LOCATION_CODE FROM HR_LOCATIONS_ALL_F_VL WHERE LOCATION_ID = WshTransitTimes.FROM_LOCATION_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN WshTransitTimes.ORIGIN_TYPE = 'R' 
	THEN (SELECT GEOGRAPHY_NAME FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_ID = WshTransitTimes.FROM_REGION_ID
			AND SYSDATE BETWEEN START_DATE AND END_DATE)
	WHEN WshTransitTimes.ORIGIN_EXT_LOC_SOURCE = 'ST' 
	THEN (SELECT PersonParty.PARTY_NAME 
			FROM HZ_PARTIES PersonParty 
			,HZ_PARTY_SITES PartySitePEO
			WHERE PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
			AND PartySitePEO.PARTY_SITE_ID = WshTransitTimes.ORIGIN_EXT_LOC_SOURCE_ID)
	WHEN WshTransitTimes.ORIGIN_EXT_LOC_SOURCE = 'SA' 
	THEN (SELECT PersonParty.PARTY_NAME||' : '||PartySitePEO.PARTY_SITE_NAME 
			FROM HZ_PARTIES PersonParty 
			,HZ_PARTY_SITES PartySitePEO
			WHERE PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
			AND PartySitePEO.PARTY_SITE_ID = WshTransitTimes.ORIGIN_EXT_LOC_SOURCE_ID)		
	WHEN WshTransitTimes.ORIGIN_TYPE = 'Z' 
	THEN (SELECT GeographyPEO.GEOGRAPHY_NAME
			FROM HZ_GEOGRAPHIES GeographyPEO
			WHERE GeographyPEO.GEOGRAPHY_USE = 'SHIPPING'
			AND GeographyPEO.GEOGRAPHY_ID = WshTransitTimes.FROM_ZONE_ID)	
	END) RES_ORIGIN
,(CASE WHEN WshTransitTimes.ORIGIN_TYPE = 'LI'
	THEN (SELECT LOCATION_NAME FROM HR_LOCATIONS_ALL_F_VL WHERE LOCATION_ID = WshTransitTimes.FROM_LOCATION_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN WshTransitTimes.ORIGIN_TYPE = 'R' 
	THEN (SELECT(
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
	FROM HZ_GEOGRAPHIES 
	WHERE GEOGRAPHY_ID = WshTransitTimes.FROM_REGION_ID
	)
	WHEN WshTransitTimes.ORIGIN_EXT_LOC_SOURCE = 'ST' 
	THEN hz_format_pub.format_address(p_location_id => WshTransitTimes.FROM_LOCATION_ID, p_line_break => ',')
	WHEN WshTransitTimes.ORIGIN_EXT_LOC_SOURCE = 'SA' 
	THEN (SELECT ADDRESS1||','||ADDRESS2||','||CITY||','||STATE||','||POSTAL_CODE||','||COUNTRY 
			FROM HZ_LOCATIONS WHERE LOCATION_ID = WshTransitTimes.FROM_LOCATION_ID)	
	WHEN WshTransitTimes.ORIGIN_TYPE = 'Z' 
	THEN (SELECT GeographyPEO.GEOGRAPHY_NAME
			FROM HZ_GEOGRAPHIES GeographyPEO
			WHERE GeographyPEO.GEOGRAPHY_USE = 'SHIPPING'
			AND GeographyPEO.GEOGRAPHY_ID = WshTransitTimes.FROM_ZONE_ID)	
	END) RES_ORIGIN_DESCRIPTION
,(CASE WHEN DESTINATION_TYPE = 'LE'
	THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'WSH_ORG_DEST_TYPE'
			AND LOOKUP_CODE = WshTransitTimes.DEST_EXT_LOC_SOURCE)
	ELSE
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'WSH_ORG_DEST_TYPE'
			AND LOOKUP_CODE = WshTransitTimes.DESTINATION_TYPE)
	END) RES_DESTINATION_TYPE
,(CASE WHEN WshTransitTimes.DESTINATION_TYPE = 'LI'
	THEN (SELECT LOCATION_CODE FROM HR_LOCATIONS_ALL_F_VL WHERE LOCATION_ID = WshTransitTimes.TO_LOCATION_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN WshTransitTimes.DESTINATION_TYPE = 'R' 
	THEN (SELECT GEOGRAPHY_NAME FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_ID = WshTransitTimes.TO_REGION_ID 
			AND SYSDATE BETWEEN START_DATE AND END_DATE)
	WHEN WshTransitTimes.DEST_EXT_LOC_SOURCE = 'ST' 
	THEN (SELECT PersonParty.PARTY_NAME 
			FROM HZ_PARTIES PersonParty 
			,HZ_PARTY_SITES PartySitePEO
			WHERE PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
			AND PartySitePEO.PARTY_SITE_ID = WshTransitTimes.DEST_EXT_LOC_SOURCE_ID)
	WHEN WshTransitTimes.DEST_EXT_LOC_SOURCE = 'SA' 
	THEN (SELECT PersonParty.PARTY_NAME||' : '||PartySitePEO.PARTY_SITE_NAME 
			FROM HZ_PARTIES PersonParty 
			,HZ_PARTY_SITES PartySitePEO
			WHERE PersonParty.PARTY_ID = PartySitePEO.PARTY_ID
			AND PartySitePEO.PARTY_SITE_ID = WshTransitTimes.DEST_EXT_LOC_SOURCE_ID)		
	WHEN WshTransitTimes.DESTINATION_TYPE = 'Z' 
	THEN (SELECT GeographyPEO.GEOGRAPHY_NAME
			FROM HZ_GEOGRAPHIES GeographyPEO
			WHERE GeographyPEO.GEOGRAPHY_USE = 'SHIPPING'
			AND GeographyPEO.GEOGRAPHY_ID = WshTransitTimes.TO_ZONE_ID)	
	END) RES_DESTINATION
,(CASE WHEN WshTransitTimes.DESTINATION_TYPE = 'LI'
	THEN (SELECT LOCATION_NAME FROM HR_LOCATIONS_ALL_F_VL WHERE LOCATION_ID = WshTransitTimes.TO_LOCATION_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN WshTransitTimes.DESTINATION_TYPE = 'R' 
	THEN (SELECT(
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
	FROM HZ_GEOGRAPHIES 
	WHERE GEOGRAPHY_ID = WshTransitTimes.TO_REGION_ID
	)
	WHEN WshTransitTimes.DEST_EXT_LOC_SOURCE = 'ST' 
	THEN hz_format_pub.format_address(p_location_id => WshTransitTimes.TO_LOCATION_ID, p_line_break => ',')
	WHEN WshTransitTimes.DEST_EXT_LOC_SOURCE = 'SA' 
	THEN (SELECT ADDRESS1||','||ADDRESS2||','||CITY||','||STATE||','||POSTAL_CODE||','||COUNTRY 
			FROM HZ_LOCATIONS WHERE LOCATION_ID = WshTransitTimes.TO_LOCATION_ID)
	WHEN WshTransitTimes.DESTINATION_TYPE = 'Z' 
	THEN (SELECT GeographyPEO.GEOGRAPHY_NAME
			FROM HZ_GEOGRAPHIES GeographyPEO
			WHERE GeographyPEO.GEOGRAPHY_USE = 'SHIPPING'
			AND GeographyPEO.GEOGRAPHY_ID = WshTransitTimes.TO_ZONE_ID)	
	END) RES_DESTINATION_DESCRIPTION
,PartyPEO.PARTY_NAME||'-'||ModeOfTransportPEO.MEANING||'-'||ServiceLevelPEO.MEANING RES_SHIPPING_METHOD
,WshTransitTimeValues.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,WshTransitTimeValues.ATTRIBUTE1 
,WshTransitTimeValues.ATTRIBUTE2
,WshTransitTimeValues.ATTRIBUTE3
,WshTransitTimeValues.ATTRIBUTE4
,WshTransitTimeValues.ATTRIBUTE5
,WshTransitTimeValues.ATTRIBUTE6
,WshTransitTimeValues.ATTRIBUTE7
,WshTransitTimeValues.ATTRIBUTE8
,WshTransitTimeValues.ATTRIBUTE9
,WshTransitTimeValues.ATTRIBUTE10
,WshTransitTimeValues.ATTRIBUTE11
,WshTransitTimeValues.ATTRIBUTE12
,WshTransitTimeValues.ATTRIBUTE13
,WshTransitTimeValues.ATTRIBUTE14
,WshTransitTimeValues.ATTRIBUTE15
,WshTransitTimeValues.ATTRIBUTE_NUMBER1 
,WshTransitTimeValues.ATTRIBUTE_NUMBER2
,WshTransitTimeValues.ATTRIBUTE_NUMBER3
,WshTransitTimeValues.ATTRIBUTE_NUMBER4
,WshTransitTimeValues.ATTRIBUTE_NUMBER5
,WshTransitTimeValues.ATTRIBUTE_NUMBER6
,WshTransitTimeValues.ATTRIBUTE_NUMBER7
,WshTransitTimeValues.ATTRIBUTE_NUMBER8
,WshTransitTimeValues.ATTRIBUTE_NUMBER9
,WshTransitTimeValues.ATTRIBUTE_NUMBER10
, TO_CHAR(WshTransitTimeValues.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(WshTransitTimeValues.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(WshTransitTimeValues.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(WshTransitTimeValues.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(WshTransitTimeValues.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
,WshTransitTimeValues.ATTRIBUTE_TIMESTAMP1 
,WshTransitTimeValues.ATTRIBUTE_TIMESTAMP2
,WshTransitTimeValues.ATTRIBUTE_TIMESTAMP3
,WshTransitTimeValues.ATTRIBUTE_TIMESTAMP4
,WshTransitTimeValues.ATTRIBUTE_TIMESTAMP5
,WshTransitTimeValues.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshTransitTimeValues.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshTransitTimeValues.CREATED_BY RSC_CREATED_BY
,WshTransitTimeValues.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_TRANSIT_TIMES WshTransitTimes
,WSH_TRANSIT_TIME_VALUES WshTransitTimeValues
,HZ_PARTIES PartyPEO
,RCS_LOOKUPS ModeOfTransportPEO
,RCS_LOOKUPS ServiceLevelPEO
WHERE WshTransitTimes.TRANSIT_TIME_ID    = WshTransitTimeValues.TRANSIT_TIME_ID
AND WshTransitTimeValues.CARRIER_ID = PartyPEO.PARTY_ID
AND WshTransitTimeValues.MODE_OF_TRANSPORT = ModeOfTransportPEO.LOOKUP_CODE
AND ModeOfTransportPEO.LOOKUP_TYPE               = 'WSH_MODE_OF_TRANSPORT'
AND WshTransitTimeValues.SERVICE_LEVEL     = ServiceLevelPEO.LOOKUP_CODE
AND ServiceLevelPEO.LOOKUP_TYPE                  = 'WSH_SERVICE_LEVELS'
AND (WshTransitTimeValues.ATTRIBUTE_CATEGORY IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE1 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE2 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE3 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE4 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE5 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE6 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE7 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE8 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE9 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE10 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE11 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE12 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE13 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE14 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE15 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER1 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER2 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER3 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER4 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER5 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER6 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER7 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER8 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER9 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_NUMBER10 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_DATE1 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_DATE2 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_DATE3 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_DATE4 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_DATE5 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_TIMESTAMP1 IS NOT NULL OR 
WshTransitTimeValues.ATTRIBUTE_TIMESTAMP2 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_TIMESTAMP3 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_TIMESTAMP4 IS NOT NULL OR
WshTransitTimeValues.ATTRIBUTE_TIMESTAMP5 IS NOT NULL)
ORDER BY 1,2