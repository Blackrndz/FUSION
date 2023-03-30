/* ****************************************************************************
* $Revision$:
* $Author$:
* $Date$:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
* $Id$:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PAY_INSTALLED_LEGISLATIONS

SELECT Head.location_name RES_NAME
,HEAD.INTERNAL_LOCATION_CODE RES_CODE
,HEAD.SET_NAME RES_LOCATION_SET
,TO_CHAR(HEAD.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT AA.action_reason
	FROM fusion.PER_ACTION_REASONS_VL AA
	,fusion.PER_ACTION_OCCURRENCES BB
	WHERE BB.action_occurrence_id = Head.action_occurrence_id
	AND AA.action_reason_id       = BB.action_reason_id
	) RES_ACTION_REASON
,DECODE(HEAD.ACTIVE_STATUS,'A','Active','I','Inactive') RES_STATUS
,(SELECT ORGANIZATION_NAME
	FROM fusion.INV_ORGANIZATION_DEFINITIONS_V
	WHERE HEAD.inventory_organization_id = organization_id
	) RES_INVENTORY_ORGANIZATION
,Head.DESCRIPTION_LOC RES_DESCRIPTION
,(SELECT geography_name
	FROM fusion.HZ_GEOGRAPHIES GEO
	WHERE GEO.COUNTRY_CODE = HEAD.country
	AND geography_type     = 'COUNTRY'
	) RES_COUNTRY
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'POSTAL_ADDR',HEAD.ADDRESS_LINE_1,NULL) RES_ADDRESS_LINE_1
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'POSTAL_ADDR',HEAD.ADDRESS_LINE_2,NULL) RES_ADDRESS_LINE_2
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.ADDRESS_LINE_1,NULL) RES_LOCATION_TYPE
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.ADDRESS_LINE_2,NULL) RES_LOCATION_NAME
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.ADDRESS_LINE_3,NULL) RES_LOCATION_NUMBER
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.BUILDING,NULL) RES_BUILDING
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.ADDRESS_LINE_4,NULL) RES_STAIRWAY
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.FLOOR_NUMBER,NULL) RES_FLOOR
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.ADDL_ADDRESS_ATTRIBUTE1,NULL) RES_DOOR
, Head.postal_code RES_POSTAL_CODE
, Head.TOWN_OR_CITY RES_SETTLEMENT
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'POSTAL_ADDR',HEAD.town_or_city,NULL) RES_CITY
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.town_or_city,NULL) RES_LOCALITY
, HEAD.region_3 RES_PROVINCE
, HEAD.ADDL_ADDRESS_ATTRIBUTE3 RES_MUNICIPIO
, HEAD.REGION_2 RES_AUTONOMIA
, HEAD.REGION_1 RES_PROVINCIA
, DECODE(HEAD.TIMEZONE_CODE, 'Pacific/Pago_Pago' , '(UTC-11:00) Pago Pago - Samoa Time (ST)'
	, 'Pacific/Honolulu' , '(UTC-10:00) Honolulu - Hawaii Time (HT)'
	, 'America/Anchorage' , '(UTC-09:00) Alaska Time (AKT)'
	, 'America/Los_Angeles' , '(UTC-08:00) Los Angeles - Pacific Time (PT)'
	, 'America/Phoenix' , '(UTC-07:00) Phoenix - Mountain Time (MT)'
	, 'America/Denver' , '(UTC-07:00) Denver - Mountain Time (MT)'
	, 'America/Regina' , '(UTC-06:00) Regina - Central Time (CT)'
	, 'America/Chicago' , '(UTC-06:00) Chicago - Central Time (CT)'
	, 'America/New_York' , '(UTC-05:00) New York - Eastern Time (ET)'
	, 'America/Halifax' , '(UTC-04:00) Canada Atlantic Time (AT)'
	, 'America/Santiago' , '(UTC-04:00) Santiago - Chile Time (CLT)'
	, 'America/Godthab' , '(UTC-03:00) Godthab - Western Greenland Time (WGT)'
	, 'America/Sao_Paulo' , '(UTC-03:00) Sao Paulo - Brasilia Time (BRT)'
	, 'America/St_Johns' , '(UTC-03:30) St Johns - Newfoundland Time (NT)'
	, 'America/Noronha' , '(UTC-02:00) Noronha - Fernando de Noronha Time (FNT)'
	, 'Europe/London', '(UTC+00:00) London - Greenwich Mean Time (GMT)'
	, 'UTC', '(UTC+00:00) Coordinated Universal Time (UTC)'
	, 'Europe/Belgrade' , '(UTC+01:00) Belgrade - Central European Time (CET)'
	, 'Africa/Tunis' , '(UTC+01:00) Tunis - Central European Time (CET)'
	, 'Europe/Warsaw' , '(UTC+01:00) Warsaw - Central European Time (CET)'
	, 'Asia/Amman' , '(UTC+02:00) Amman - Eastern European Time (EET)'
	, 'Asia/Beirut' , '(UTC+02:00) Beirut - Eastern European Time (EET)'
	, 'Africa/Cairo' , '(UTC+02:00) Cairo - Egypt Time (ET)'
	, 'Asia/Damascus' , '(UTC+02:00) Damascus - Eastern European Time (EET)'
	, 'Europe/Istanbul' , '(UTC+02:00) Istanbul - Eastern European Time (EET)'
	, 'Asia/Jerusalem' , '(UTC+02:00) Jerusalem - Israel Time (IT)'
	, 'Africa/Tripoli' , '(UTC+02:00) Tripoli - Eastern European Time (EET)'
	, 'Asia/Baghdad' , '(UTC+03:00) Baghdad - Arabia Time (AT)'
	, 'Europe/Moscow' , '(UTC+03:00) Moscow - Moscow Time (MSK)'
	, 'Asia/Riyadh' , '(UTC+03:00) Riyadh - Arabia Time (AT)'
	, 'Asia/Tehran' , '(UTC+03:30) Tehran - Iran Time (IRT)'
	, 'Asia/Dubai' , '(UTC+04:00) Dubai - Gulf Time (GT)'
	, 'Asia/Yekaterinburg' , '(UTC+05:00) Yekaterinburg - Yekaterinburg Time (YEKT)'
	, 'Asia/Calcutta' , '(UTC+05:30) Calcutta - India Time (IT)'
	, 'Asia/Kathmandu' , '(UTC+05:45) Kathmandu - Nepal Time (NPT)'
	, 'Asia/Almaty' , '(UTC+06:00) Almaty - Alma-Ata Time (ALMT)'
	, 'Asia/Dhaka' , '(UTC+06:00) Dhaka - Bangladesh Time (BDT)'
	, 'Asia/Bangkok' , '(UTC+07:00) Bangkok - Indochina Time (ICT)'
	, 'Asia/Krasnoyarsk' , '(UTC+07:00) Krasnoyarsk - Krasnoyarsk Time (KRAT)'
	, 'Asia/Hong_Kong' , '(UTC+08:00) Hong Kong - Hong Kong Time (HKT)'
	, 'Asia/Irkutsk' , '(UTC+08:00) Irkutsk - Irkutsk Time (IRKT)'
	, 'Asia/Tokyo' , '(UTC+09:00) Tokyo - Japan Time (JT)'
	, 'Asia/Yakutsk' , '(UTC+09:00) Yakutsk - Yakutsk Time (YAKT)'
	, 'Australia/Adelaide' , '(UTC+09:30) Adelaide - Central Time (South Australia) (CT)'
	, 'Australia/Darwin' , '(UTC+09:30) Darwin - Central Time (Northern Territory) (CT)'
	, 'Australia/Brisbane' , '(UTC+10:00) Brisbane - Eastern Time (Queensland) (ET)'
	, 'Australia/Hobart' , '(UTC+10:00) Hobart - Eastern Time (Tasmania) (ET)'
	, 'Australia/Sydney' , '(UTC+10:00) Sydney - Eastern Time (New South Wales) (ET)'
	, 'Asia/Magadan' , '(UTC+11:00) Magadan - Magadan Time (MAGT)'
	, 'Pacific/Auckland' , '(UTC+12:00) Auckland - New Zealand Time (NZT)'
	, 'Asia/Kamchatka' , '(UTC+12:00) Kamchatka - Petropavlovsk-Kamchatski Time (PETT)'
	) RES_TIME_ZONE_CODE
, Head.DESCRIPTION RES_OFFICIAL_LANGUAGE
, Head.email_address RES_E_MAIL
, Head.geo_hierarchy_node_id RES_GEOGRAPHIC_HIERARCHY
, Head.mainphone_country_code1 RES_MAIN_PHONE_COUNTRY_CODE
, Head.mainphone_area_code1 RES_MAIN_PHONE_AREA_CODE
, Head.mainphone_subscriber_num1 RES_MAIN_PHONE_LOCAL_NUMBER
, Head.mainphone_extension1 RES_MAIN_PHONE_EXTENSION
, Head.fax_country_code2 RES_FAX_COUNTRY_CODE
, Head.fax_area_code2 RES_FAX_AREA_CODE
, Head.fax_subscriber_num2 RES_FAX_LOCAL_NUMBER
, Head.fax_extension2 RES_FAX_EXTENSION
, Head.otherphone_country_code3 RES_OTHER_PHONE_COUNTRY_CODE
, Head.otherphone_area_code3 RES_OTHER_PHONE_AREA_CODE
, Head.otherphone_subscriber_num3 RES_OTHER_PHONE_LOCAL_NUMBER
, Head.otherphone_extension3 RES_OTHER_PHONE_EXTENSION
, DECODE(HEAD.SHIP_TO_SITE_FLAG,'Y','Yes','No') RES_SHIP_TO_SITE
, DECODE(HEAD.SHIP_TO_SITE_FLAG,'Y',NULL,Ship_LOC.location_name) RES_SHIP_TO_LOCATION_NAME
, DECODE(HEAD.SHIP_TO_SITE_FLAG,'Y',NULL,Ship_LOC.location_code) RES_SHIP_TO_LOCATION_CODE
, DECODE(HEAD.RECEIVING_SITE_FLAG,'Y','Yes','No') RES_RECEIVING_SITE
, DECODE(HEAD.BILL_TO_SITE_FLAG,'Y','Yes','No') RES_BILL_TO_SITE
, DECODE(HEAD.OFFICE_SITE_FLAG,'Y','Yes','No') RES_OFFICE_SITE
, PersonDetail.LIST_NAME RES_DESIGNATED_RECEIVER_NAME
, PersonDetail.EMAIL_ADDRESS RES_DESIGNATED_RECEIVER_E_MAIL
, DECODE(ES_PRL_NO.lei_information1,'Y','Yes','N','No') RES_SPANISH_PROPERTY_NOT_RENTE
, DECODE(ES_PRL_YES.lei_information1,'Y','Yes','N','No') RES_SPANISH_PROPERTY_RENTED_PR
, ES_PRL_YES.lei_information2 RES_SPANISH_PROPERTY_RENTED_RA
, DECODE(ES_RENTED_LOCATION.lei_information1,'Y','Yes','N','No') RES_SPANISH_PROPERTY_RENTALS_P
, ES_RENTED_LOCATION.lei_information2 RES_SPANISH_PROPERTY_RENTALS_R
, ES_RENTED_LOCATION.lei_information3 RES_STAIR_NUMBER
, ES_RENTED_LOCATION.lei_information4 RES_FLOOR_NUMBER
, ES_RENTED_LOCATION.lei_information5 RES_DOOR_NUMBER
, ES_PROPERTY_LOCATION.LEI_INFORMATION2 RES_LAND_REGISTRY_REFERENCE
, (SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL
	WHERE TERRITORY_CODE = ES_PROPERTY_LOCATION.LEI_INFORMATION17
	) RES_PROPERTY_LOCATION_FOR_SPAI
, (SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'JEES_PROVINCES'
	AND LOOKUP_CODE = ES_PROPERTY_LOCATION.LEI_INFORMATION15 
	) RES_PROPERTY_LOCATION_FOR_SP_0 --
, ES_PROPERTY_LOCATION.LEI_INFORMATION14 RES_PROPERTY_LOCATION_FOR_SP_1
, ES_PROPERTY_LOCATION.LEI_INFORMATION16 RES_PROPERTY_LOCATION_FOR_SP_2
, (SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'JEES_STREET_TYPES'
	AND LOOKUP_CODE = ES_PROPERTY_LOCATION.LEI_INFORMATION11 
	) RES_PROPERTY_LOCATION_FOR_SP_3
, ES_PROPERTY_LOCATION.LEI_INFORMATION12 RES_PROPERTY_LOCATION_FOR_SP_4
, ES_PROPERTY_LOCATION.LEI_INFORMATION13 RES_PROPERTY_LOCATION_FOR_SP_5
, (SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'JEES_NUMBER_TYPE'
	AND LOOKUP_CODE = ES_PROPERTY_LOCATION.LEI_INFORMATION6
	) RES_PROPERTY_LOCATION_FOR_SP_6
, (SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'JEES_NUMBER_QUALIFIER'
	AND LOOKUP_CODE = ES_PROPERTY_LOCATION.LEI_INFORMATION7
	) RES_PROPERTY_LOCATION_FOR_SP_7
, ES_PROPERTY_LOCATION.LEI_INFORMATION8 RES_PROPERTY_LOCATION_FOR_SP_8
, ES_PROPERTY_LOCATION.LEI_INFORMATION9 RES_PROPERTY_LOCATION_FOR_SP_9
, ES_PROPERTY_LOCATION.LEI_INFORMATION3 RES_PROPERTY_LOCATION_FOR_S_10
, ES_PROPERTY_LOCATION.LEI_INFORMATION4 RES_PROPERTY_LOCATION_FOR_S_11
, ES_PROPERTY_LOCATION.LEI_INFORMATION5 RES_PROPERTY_LOCATION_FOR_S_12
, ES_PROPERTY_LOCATION.LEI_INFORMATION10 RES_PROPERTY_LOCATION_FOR_S_13
, Head.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, Head.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
, Head.CREATED_BY RSC_CREATED_BY
, Head.CREATION_DATE RSC_CREATION_DATE
, NULL RSC_LEDGER_ID
, NULL RSC_CHART_OF_ACCOUNTS_ID
, NULL RSC_BUSINESS_UNIT_ID
, NULL RSC_LEGAL_ENTITY_ID
,Head.inventory_organization_id RSC_ORGANIZATION_ID
, NULL RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM
	(SELECT LocationDetailTranslationDEO.LOCATION_CODE
	, LocationEO.INTERNAL_LOCATION_CODE
	, LocationDetailDEO.ACTIVE_STATUS
	, SetIdSetPEO.SET_NAME
	, TerritoryPEO.TERRITORY_SHORT_NAME
	, AddressDPEO.TOWN_OR_CITY
	, AddressDPEO.POSTAL_CODE
	, InventoryOrganization.ORGANIZATION_NAME
	, ShippingLocation.LOCATION_CODE AS LOCATION_CODE1
	, LanguagePEO.DESCRIPTION
	, LocationDetailDEO.OFFICE_SITE_FLAG
	, LocationDetailDEO.SHIP_TO_SITE_FLAG
	, LocationDetailDEO.RECEIVING_SITE_FLAG
	, LocationDetailDEO.BILL_TO_SITE_FLAG
	, AddressDPEO.ADDRESS_LINE_1
	, AddressDPEO.ADDRESS_LINE_2
	, AddressDPEO.ADDRESS_LINE_3
	, AddressDPEO.ADDRESS_LINE_4
	, AddressDPEO.BUILDING
	, AddressDPEO.REGION_1 
	, AddressDPEO.REGION_2
	, AddressDPEO.REGION_3 
	, AddressDPEO.FLOOR_NUMBER
	, AddressDPEO.ADDL_ADDRESS_ATTRIBUTE1
	, AddressDPEO.ADDL_ADDRESS_ATTRIBUTE3
	, TimezonePEO.NAME
	, AddressDPEO.TIMEZONE_CODE
	, LocationEO.SET_ID
	, LocationDetailDEO.LOCATION_DETAILS_ID
	, LocationDetailTranslationDEO.LANGUAGE
	, LocationEO.LOCATION_ID
	, SetIdSetPEO.SET_ID                               AS SET_ID1
	, LocationDetailTranslationDEO.LOCATION_DETAILS_ID AS LOCATION_DETAILS_ID1
	, LanguagePEO.LANGUAGE_CODE
	, InventoryOrganization.ORGANIZATION_ID
	, LocationEO.LOCATION_IMAGE_URL
	, LocationDetailDEO.geo_hierarchy_node_id
	, AddressDPEO.COUNTRY
	,(ROWNUM)                      AS MAP_SEQUENCE
	, ShippingLocation.LOCATION_ID AS LOCATION_ID1
	, AddressDPEO.ADDRESS_ID
	, TerritoryPEO.TERRITORY_CODE
	,(AddressDPEO.GEOMETRY.SDO_POINT.X) AS LOC_LONGITUDE
	,(AddressDPEO.GEOMETRY.SDO_POINT.Y) AS LOC_LATITUDE
	, LocationEO.OBJECT_VERSION_NUMBER
	, TimezonePEO.TIMEZONE_CODE AS TIMEZONE_CODE1
	, LocationDetailTranslationDEO.DESCRIPTION DESCRIPTION_LOC
	, ShippingLocation.email_address
	, LocationDetailTranslationDEO.location_code CODE
	, LocationDetailTranslationDEO.location_name
	, ShippingLocation.designated_receiver_id
	, LocationDetailDEO.mainphone_country_code1
	, LocationDetailDEO.mainphone_area_code1
	, LocationDetailDEO.mainphone_subscriber_num1
	, LocationDetailDEO.mainphone_extension1
	, LocationDetailDEO.fax_country_code2
	, LocationDetailDEO.fax_area_code2
	, LocationDetailDEO.fax_subscriber_num2
	, LocationDetailDEO.fax_extension2
	, LocationDetailDEO.otherphone_country_code3
	, LocationDetailDEO.otherphone_area_code3
	, LocationDetailDEO.otherphone_subscriber_num3
	, LocationDetailDEO.otherphone_extension3
	, LocationDetailDEO.ship_to_location_id
	, LocationDetailTranslationDEO.ac_location_code
	, LocationEO.last_updated_by
	, LocationEO.last_update_date
	, LocationEO.CREATED_BY
	, LocationEO.CREATION_DATE
	, LocationDetailDEO.EFFECTIVE_START_DATE
	, LocationDetailDEO.EFFECTIVE_END_DATE
	, LocationDetailDEO.Business_group_id
	, LocationDetailDEO.inventory_organization_id
	, LocationEO.action_occurrence_id
	FROM fusion.PER_LOCATIONS LocationEO
	, fusion.PER_LOCATION_DETAILS_F LocationDetailDEO
	, fusion.PER_LOCATION_DETAILS_F_TL LocationDetailTranslationDEO
	, fusion.PER_LOC_ADDRESS_USAGES_F LocationAddressUsageDEO
	, fusion.FND_LANGUAGES_VL LanguagePEO
	, fusion.INV_ORGANIZATION_DEFINITIONS_V InventoryOrganization
	, fusion.FND_SETID_SETS_VL SetIdSetPEO
	, fusion.HR_LOCATIONS_ALL_F_VL ShippingLocation
	, fusion.PER_ADDRESSES_F AddressDPEO
	, fusion.FND_TERRITORIES_VL TerritoryPEO
	, fusion.FND_TIMEZONES_VL TimezonePEO
	WHERE(((((((((((LocationEO.LOCATION_ID           = LocationDetailDEO.LOCATION_ID)
	AND((LocationDetailDEO.LOCATION_DETAILS_ID       = LocationDetailTranslationDEO.LOCATION_DETAILS_ID)
	AND(LocationDetailDEO.EFFECTIVE_START_DATE       = LocationDetailTranslationDEO.EFFECTIVE_START_DATE)))
	AND(LocationDetailTranslationDEO.LANGUAGE        = userenv('LANG')))
	AND(LocationEO.LOCATION_ID                       = LocationAddressUsageDEO.LOCATION_ID))
	AND(LanguagePEO.LANGUAGE_CODE (+)                = LocationDetailDEO.OFFICIAL_LANGUAGE_CODE))
	AND(LocationDetailDEO.INVENTORY_ORGANIZATION_ID  = InventoryOrganization.ORGANIZATION_ID(+)))
	AND(LocationEO.SET_ID                            = SetIdSetPEO.SET_ID))
	AND((LocationAddressUsageDEO.ADDRESS_USAGE_TYPE  = 'MAIN')
	AND(LocationAddressUsageDEO.EFFECTIVE_START_DATE = LocationDetailDEO.EFFECTIVE_START_DATE)))
	AND((LocationDetailDEO.SHIP_TO_LOCATION_ID       = ShippingLocation.LOCATION_ID)
	AND(LocationDetailDEO.EFFECTIVE_START_DATE BETWEEN ShippingLocation.EFFECTIVE_START_DATE AND
		ShippingLocation.EFFECTIVE_END_DATE)))
	AND((LocationDetailDEO.MAIN_ADDRESS_ID     = AddressDPEO.ADDRESS_ID)
	AND(LocationDetailDEO.EFFECTIVE_START_DATE = AddressDPEO.EFFECTIVE_START_DATE)))
	AND(TerritoryPEO.TERRITORY_CODE            = AddressDPEO.COUNTRY))
	AND(AddressDPEO.TIMEZONE_CODE              = TimezonePEO.TIMEZONE_CODE(+))
	AND SYSDATE BETWEEN LocationDetailDEO.EFFECTIVE_START_DATE AND LocationDetailDEO.EFFECTIVE_END_DATE
	) HEAD
,(SELECT AAA.location_id
	, AAA.lei_information1
	, AAA.EFFECTIVE_START_DATE
	, AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_EXTRA_INFO_F AAA
	, fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lei_information_category = 'JE_ES_PRL_NO'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	) ES_PRL_NO
,(SELECT AAA.location_id
	, AAA.lei_information1
	, AAA.lei_information2
	, AAA.EFFECTIVE_START_DATE
	, AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_EXTRA_INFO_F AAA
	, fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lei_information_category = 'JE_ES_PRL_YES'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	) ES_PRL_YES
,(SELECT AAA.location_id
	, AAA.lei_information1
	, AAA.lei_information2
	, AAA.lei_information3
	, AAA.lei_information4
	, AAA.lei_information5
	, AAA.EFFECTIVE_START_DATE
	, AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_EXTRA_INFO_F AAA
	, fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lei_information_category = 'JE_ES_RENTED_LOCATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	) ES_RENTED_LOCATION
,(SELECT AA.location_name
	, CC.location_id
	, CC.EFFECTIVE_START_DATE
	, CC.EFFECTIVE_END_DATE
	,(SELECT INTERNAL_LOCATION_CODE
		FROM PER_LOCATIONS
		WHERE LOCATION_ID = BB.LOCATION_ID) LOCATION_CODE
	FROM fusion.PER_LOCATION_DETAILS_F_TL AA
	, fusion.PER_LOCATION_DETAILS_F BB
	, fusion.PER_LOCATION_DETAILS_F CC
	WHERE AA.location_details_id = BB.location_details_id
	AND BB.location_id           = CC.ship_to_location_id
	AND((CC.EFFECTIVE_START_DATE BETWEEN AA.EFFECTIVE_START_DATE(+) AND AA.EFFECTIVE_END_DATE(+))
	AND(CC.EFFECTIVE_END_DATE BETWEEN AA.EFFECTIVE_START_DATE(+) AND AA.EFFECTIVE_END_DATE(+)))
	AND AA.LANGUAGE = USERENV('LANG')
	) Ship_LOC
,(SELECT PersonDPEO.PERSON_ID
	,PersonNameDPEO.LIST_NAME
	,EmailAddressPEO.EMAIL_ADDRESS
	FROM PER_ALL_PEOPLE_F PersonDPEO
	,PER_EMAIL_ADDRESSES EmailAddressPEO
	,PER_PERSON_NAMES_F_V PersonNameDPEO
	WHERE EmailAddressPEO.EMAIL_ADDRESS_ID(+) = PersonDPEO.PRIMARY_EMAIL_ID
	AND PersonDPEO.PERSON_ID                  = PersonNameDPEO.PERSON_ID
	) PersonDetail
,(SELECT AAA.location_id
	, AAA.lei_information1, AAA.lei_information2, AAA.lei_information3, AAA.lei_information4, AAA.lei_information5
	, AAA.lei_information6, AAA.lei_information7, AAA.lei_information8, AAA.lei_information9, AAA.lei_information10
	, AAA.lei_information11, AAA.lei_information12, AAA.lei_information13, AAA.lei_information14, AAA.lei_information15
	, AAA.lei_information16, AAA.lei_information17
	, AAA.EFFECTIVE_START_DATE
	, AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_EXTRA_INFO_F AAA
	, fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lei_information_category = 'JExESPropertyLocation'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	) ES_PROPERTY_LOCATION
,PAY_INSTALLED_LEGISLATIONS AddressFormatE0
WHERE((HEAD.location_id = ES_PRL_NO.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN ES_PRL_NO.EFFECTIVE_START_DATE(+) AND ES_PRL_NO.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN ES_PRL_NO.EFFECTIVE_START_DATE(+) AND ES_PRL_NO.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = ES_PRL_YES.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN ES_PRL_YES.EFFECTIVE_START_DATE(+) AND ES_PRL_YES.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN ES_PRL_YES.EFFECTIVE_START_DATE(+) AND ES_PRL_YES.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = ES_RENTED_LOCATION.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN ES_RENTED_LOCATION.EFFECTIVE_START_DATE(+) AND
	ES_RENTED_LOCATION.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN ES_RENTED_LOCATION.EFFECTIVE_START_DATE(+) AND
	ES_RENTED_LOCATION.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = Ship_LOC.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Ship_LOC.EFFECTIVE_START_DATE(+) AND Ship_LOC.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Ship_LOC.EFFECTIVE_START_DATE(+) AND Ship_LOC.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = ES_PROPERTY_LOCATION.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN ES_PROPERTY_LOCATION.EFFECTIVE_START_DATE(+) AND ES_PROPERTY_LOCATION.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN ES_PROPERTY_LOCATION.EFFECTIVE_START_DATE(+) AND ES_PROPERTY_LOCATION.EFFECTIVE_END_DATE(+))))
AND Head.designated_receiver_id = PersonDetail.PERSON_ID(+)
AND head.country = AddressFormatE0.LEGISLATION_CODE(+)
AND head.country = 'ES'
ORDER BY (CASE
	WHEN EXISTS (SELECT 1 FROM PER_LOCATIONS WHERE LOCATION_ID = Ship_LOC.LOCATION_ID) THEN	3
	ELSE 4 
	END)
,RES_NAME
,RES_CODE