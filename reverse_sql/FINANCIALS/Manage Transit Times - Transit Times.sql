/* ****************************************************************************
* $Revision: 79377 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-09-21 18:00:34 +0700 (Wed, 21 Sep 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transit%20Times%20-%20Transit%20Times.sql $:
* $Id: Manage Transit Times - Transit Times.sql 79377 2022-09-21 11:00:34Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=WSH_TRANSIT_TIMES

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
,WshTransitTimes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WshTransitTimes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WshTransitTimes.CREATED_BY RSC_CREATED_BY
,WshTransitTimes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_TRANSIT_TIMES WshTransitTimes
ORDER BY 1,2