/* ****************************************************************************
 * $Revision: 78576 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-05-25 16:20:21 +0700 (Wed, 25 May 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Legal%20Reporting%20Unit%20-%20Croatia.sql $:
 * $Id: Manage Legal Reporting Unit - Croatia.sql 78576 2022-05-25 09:20:21Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT QRSLT.NAME RES_LEGAL_ENTITY
,(SELECT LEGAL_ENTITY_IDENTIFIER
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = QRSLT.LEGAL_ENTITY_ID
	) RES_LEGAL_ENTITY_IDENTIFIER
,QRSLT.GEOGRAPHY_NAME RES_TERRITORY
,QRSLT.REGISTERED_NAME RES_LEGAL_REPORTING_UNIT_NAME
,QRSLT.REGISTRATION_NUMBER RES_LEGAL_REPORTING_UNIT_REGIS
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y','Yes','No') RES_PRIMARY
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',') RES_ADDRESS
,partySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,partySitesE0.MAILSTOP	RES_MAIL_STOP
,(select TERRITORYPEO.TERRITORY_SHORT_NAME	
  from FND_TERRITORIES_VL TERRITORYPEO
  where TERRITORYPEO.TERRITORY_CODE =   locationsE0.COUNTRY )	RES_COUNTRY
,locationsE0.ADDRESS1	RES_ADDRESS_LINE_1
,locationsE0.ADDRESS2	RES_ADDRESS_LINE_2
,locationsE0.ADDRESS3	RES_ADDRESS_LINE_3
,locationsE0.CITY	RES_CITY
,locationsE0.STATE	RES_STATE
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
,null RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM
	(SELECT XleEtbProfiles.PARTY_ID
	,XleEtbProfiles.LEGAL_ENTITY_ID
	,XleEtbProfiles.ENTERPRISE_ID
	,(SELECT NAME
		FROM XLE_ENTITY_PROFILES
		WHERE LEGAL_ENTITY_ID = XleEtbProfiles.LEGAL_ENTITY_ID
		) NAME
	,XleEtbProfiles.MAIN_ESTABLISHMENT_FLAG
	,XleEtbProfiles.MAIN_EFFECTIVE_FROM
	,XleEtbProfiles.MAIN_EFFECTIVE_TO
	,XleEtbProfiles.EFFECTIVE_FROM
	,XleEtbProfiles.EFFECTIVE_TO
	,XleEtbProfiles.LAST_UPDATED_BY
	,XleEtbProfiles.CREATION_DATE
	,XleEtbProfiles.LAST_UPDATE_DATE
	,XleEtbProfiles.CREATED_BY
	,XleEtbProfiles.ACTIVITY_CODE
	,XleEtbProfiles.SUB_ACTIVITY_CODE
	,XleEtbProfiles.TYPE_OF_COMPANY
	,RegistrationEO.REGISTERED_NAME
	,RegistrationEO.REGISTRATION_NUMBER
	,hz_format_pub.format_address(p_location_id => RegistrationEO.LOCATION_ID, p_line_break => ',') FORMATTED_ADDRESS
	,GeographyPEO.GEOGRAPHY_NAME
	,GeographyPEO.GEOGRAPHY_TYPE
	,GeographyPEO.GEOGRAPHY_ID
	,Jurisdictions.JURISDICTION_ID
	FROM XLE_ETB_PROFILES XleEtbProfiles
	,XLE_REGISTRATIONS RegistrationEO
	,HZ_GEOGRAPHIES GeographyPEO
	,XLE_JURISDICTIONS_VL Jurisdictions
	WHERE((XleEtbProfiles.ESTABLISHMENT_ID = RegistrationEO.SOURCE_ID(+)
	AND REGISTRATIONEO.IDENTIFYING_FLAG(+) = 'Y'))
	AND(XLEETBPROFILES.GEOGRAPHY_ID = GEOGRAPHYPEO.GEOGRAPHY_ID)
	AND XLEETBPROFILES.GEOGRAPHY_ID = Jurisdictions.GEOGRAPHY_ID
	AND RegistrationEO.JURISDICTION_ID = Jurisdictions.JURISDICTION_ID
	) QRSLT
,HZ_PARTY_SITES partySitesE0
,HZ_LOCATIONS locationsE0
WHERE QRSLT.PARTY_ID = partySitesE0.PARTY_ID
AND partySitesE0.STATUS = 'A'
AND partySitesE0.LOCATION_ID = locationsE0.LOCATION_ID
AND locationsE0.COUNTRY =  'HR'
ORDER BY QRSLT.NAME
,DECODE(partySitesE0.IDENTIFYING_ADDRESS_FLAG,'Y',1,2)
,hz_format_pub.format_address(p_location_id => partySitesE0.LOCATION_ID, p_line_break => ',')