/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-07-09 $:
 * $HeadURL:$:
 * $Id: Manage Bank Branch Addresses - Montenegro.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT PartyPEO.PARTY_NAME RES_NAME
,PartyPEO.PARTY_NUMBER RES_ORGANIZATION_NUMBER
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y','Yes','No')	RES_PRIMARY
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',') RES_ADDRESS
,partySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,partySitesE0.MAILSTOP	RES_MAIL_STOP
,(select TERRITORYPEO.TERRITORY_SHORT_NAME	
  from FND_TERRITORIES_VL TERRITORYPEO
  where TERRITORYPEO.TERRITORY_CODE =   locationsE0.COUNTRY )	RES_COUNTRY
,locationsE0.ADDRESS1	RES_ADDRESS_LINE_1
,locationsE0.ADDRESS2	RES_ADDRESS_LINE_2
,locationsE0.ADDRESS3	RES_ADDRESS_LINE_3
,locationsE0.CITY		RES_CITY
,locationsE0.STATE		RES_STATE
,locationsE0.POSTAL_CODE	RES_POSTAL_CODE
,(SELECT NAME FROM FND_TIMEZONES_VL WHERE TIMEZONE_CODE = locationsE0.TIMEZONE_CODE) RES_TIME_ZONE
,DECODE(partySitesE0.PARTY_SITE_TYPE,NULL,'No','Yes')	RES_ONE_TIME_ADDRESS
,TO_CHAR(partySitesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') 	RES_FROM_DATE
,TO_CHAR(partySitesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') 	RES_TO_DATE

,partySitesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,partySitesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,partySitesE0.CREATED_BY  RSC_CREATED_BY
,partySitesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTY_SITES partySitesE0
,HZ_ORGANIZATION_PROFILES OrganizationPEO
,HZ_GEOGRAPHIES GeographyPEO
,HZ_PARTIES PartyPEO
,FND_TERRITORIES_VL TerritoryPEO
,HZ_PARTY_USG_ASSIGNMENTS PartyUsageAssignmentPEO
,HZ_LOCATIONS locationsE0
WHERE((PartyUsageAssignmentPEO.PARTY_ID = partypeo.party_id)
AND(PartyUsageAssignmentPEO.party_usage_code = 'LEGAL_AUTHORITY')
AND(locationsE0.location_id(+) = partySitesE0.location_id)
AND(partypeo.party_id = partySitesE0.party_id(+))
AND(partypeo.party_id = organizationpeo.party_id)
AND(organizationpeo.effective_start_date <= sysdate
AND organizationpeo.effective_end_date > sysdate)
AND(geographypeo.geography_code = territorypeo.territory_code(+))
AND(geographypeo.geography_code(+) = locationsE0.country)
AND(geographypeo.geography_type(+) = 'COUNTRY')
--AND partySitesE0.PARTY_SITE_TYPE NOT IN 'ONE_TIME' 
--AND(partySitesE0.IDENTIFYING_ADDRESS_FLAG(+) = 'Y')
AND NVL(partySitesE0.STATUS(+),'A') = 'A'
AND NVL(TRUNC(partySitesE0.START_DATE_ACTIVE(+)),TRUNC(SYSDATE)) <= TRUNC(SYSDATE)
AND NVL(TRUNC(partySitesE0.END_DATE_ACTIVE(+)),TRUNC(SYSDATE) + 1) > TRUNC(SYSDATE)
AND NVL(organizationpeo.STATUS,'A') = 'A'
AND NVL(TRUNC(organizationpeo.EFFECTIVE_START_DATE),TRUNC(SYSDATE)) <= TRUNC(SYSDATE)
AND NVL(TRUNC(organizationpeo.EFFECTIVE_END_DATE),TRUNC(SYSDATE) + 1) > TRUNC(SYSDATE))
AND locationsE0.COUNTRY = 'ME'
ORDER BY PartyPEO.PARTY_NAME
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y',1,2)
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',')