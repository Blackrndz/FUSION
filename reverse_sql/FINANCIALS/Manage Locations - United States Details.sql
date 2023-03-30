/* ****************************************************************************
 * $Revision: 80146 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-02-10 17:05:41 +0700 (Fri, 10 Feb 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20-%20United%20States%20Details.sql $:
 * $Id: Manage Locations - United States Details.sql 80146 2023-02-10 10:05:41Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PAY_INSTALLED_LEGISLATIONS

WITH SHIP_LOC AS(SELECT CC.SHIP_TO_LOCATION_ID LOCATION_ID
    ,CC.EFFECTIVE_START_DATE
    ,CC.EFFECTIVE_END_DATE
    ,(SELECT LOCATION_NAME
        FROM PER_LOCATION_DETAILS_F_VL
        WHERE LOCATION_ID = CC.SHIP_TO_LOCATION_ID
        AND CC.EFFECTIVE_END_DATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE 
        ) LOCATION_NAME
    ,(SELECT INTERNAL_LOCATION_CODE
        FROM PER_LOCATIONS
        WHERE LOCATION_ID = CC.SHIP_TO_LOCATION_ID
        ) LOCATION_CODE
    FROM PER_LOCATION_DETAILS_F CC)
	
SELECT Head.location_name RES_NAME
,Head.INTERNAL_LOCATION_CODE RES_CODE
,Head.SET_NAME RES_LOCATION_SET
,TO_CHAR(HEAD.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT AA.action_reason
	FROM fusion.PER_ACTION_REASONS_VL AA
	,fusion.PER_ACTION_OCCURRENCES BB
	WHERE BB.action_occurrence_id = Head.action_occurrence_id
	AND AA.action_reason_id       = BB.action_reason_id
	) RES_ACTION_REASON
,DECODE(Head.ACTIVE_STATUS,'A','Active','I','Inactive') RES_STATUS
,(SELECT ORGANIZATION_NAME
	FROM fusion.INV_ORGANIZATION_DEFINITIONS_V
	WHERE Head.inventory_organization_id = organization_id
	) RES_INVENTORY_ORGANIZATION
,Head.DESCRIPTION_LOC RES_DESCRIPTION
,(SELECT geography_name
	FROM fusion.HZ_GEOGRAPHIES GEO
	WHERE GEO.COUNTRY_CODE = HEAD.country
	AND geography_type     = 'COUNTRY'
	) RES_COUNTRY
, HEAD.ADDRESS_LINE_1 RES_ADDRESS_LINE_1
, HEAD.ADDRESS_LINE_2 RES_ADDRESS_LINE_2
, HEAD.ADDRESS_LINE_3 RES_ADDRESS_LINE_3
, HEAD.town_or_city RES_CITY
, HEAD.region_2 RES_STATE
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'POSTAL_ADDR',Head.postal_code,NULL) RES_POSTAL_CODE
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.postal_code,NULL) RES_ZIP_CODE
, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.ADDL_ADDRESS_ATTRIBUTE4,NULL) RES_TAX_DISTRICT
, HEAD.REGION_1 RES_COUNTY
--, DECODE(NVL(AddressFormatE0.ADDRESS_STYLE_CODE,'POSTAL_ADDR'),'SUPP_TAX_AND_RPTNG_ADDR',HEAD.REGION_1,NULL) RES_COUNTY
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
, (SELECT PK2_START_VALUE
	FROM PER_GEO_TREE_NODE
	WHERE TREE_NODE_ID = Head.geo_hierarchy_node_id
	) RES_GEOGRAPHIC_HIERARCHY
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
, Head.designated_receiver_id RES_DESIGNATED_RECEIVER_NAME
, '' RES_DESIGNATED_RECEIVER_E_MAIL
, Work_Site.lle_information1 RES_TRADE_NAME
, Work_Site.lle_information2 RES_WORKSITE_DESCRIPTION
, Work_Site.lle_information3 RES_UNITED_STATES_MULTIPLE_WOR
/*, Work_Site.lle_information4 RES_COMMENT_CODE_1
, Work_Site.lle_information5 RES_COMMENT_CODE_2
, Work_Site.lle_information6 RES_COMMENT_CODE_3*/
, Work_Site.lle_information7 RES_COMMENT
, DECODE(Work_Site.attribute1,'Y','Yes','N','No') RES_INCLUDE_FOR_REPORTING
/*, DECODE(Report.lle_information1,'Y','Yes','N','No') RES_APPRENTICES_EMPLOYED
, DECODE(Report.lle_information2,'Y','Yes','N','No') RES_GOVERNMENT_CONTRACTOR*/
, DECODE(Report.lle_information3,'Y','Yes','N','No') RES_HEADQUARTERS_ESTABLISHMENT
, Report.lle_information4 RES_D_U_N_S_NUMBER
, Report.lle_information5 RES_NAICS_NUMBER
, Veteran.lle_information1 RES_UNITED_STATES_VETERAN_REPO
, Veteran.lle_information2 RES_HIRING_LOCATION_NUMBER
, EMP.lle_information_number1 RES_MAXIMUM_NUMBER_OF_EMPLOYEE
, EMP.lle_information_number2 RES_MINIMUM_NUMBER_OF_EMPLOYEE
, EEO.lle_information1 RES_UNITED_STATES_EEO_1_REPORT
, EEO.lle_information2 RES_UNITED_STATES_EEO_1_REPO_0
--, EEO.lle_information3 RES_SIC_NUMBER
, EEO.lle_information4 RES_MAIN_ACTIVITIES_LINE_1
, EEO.lle_information5 RES_MAIN_ACTIVITIES_LINE_2
, EEO.lle_information6 RES_MAIN_ACTIVITIES_LINE_3
, EEO.lle_information7 RES_MAIN_ACTIVITIES_LINE_4
, DECODE(EEO.lle_information8,'Y','Yes','N','No') RES_REPORTED_LAST_YEAR
, UN_EMPLOY.attribute_number1 RES_EMPLOYER_UNIT_NUMBER
, PSD.lle_information1 RES_PSD_CODE_FOR_PENNSYLVANIA_
, PSD.lle_information2 RES_NON_RESIDENT_EIT_RATE_FOR_
, DECODE(HR_PROXY.LLE_INFORMATION1,'Y','Yes','N','No') RES_HR_REPORTING_LOCATION
, HR_PROXY.HR_REPORT RES_HR_REPORTING_PROXY
,Head.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Head.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Head.CREATED_BY RSC_CREATED_BY
,Head.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
, NULL RSC_ORGANIZATION_ID
, NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

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
	, AddressDPEO.ADDRESS_LINE_3
	, AddressDPEO.ADDL_ADDRESS_ATTRIBUTE4
	, AddressDPEO.REGION_1
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
	, AddressDPEO.address_line_2
	, AddressDPEO.region_2
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
	,ShippingLocation.email_address
	,LocationDetailTranslationDEO.location_code CODE
	,LocationDetailTranslationDEO.location_name
	,ShippingLocation.designated_receiver_id
	,LocationDetailDEO.mainphone_country_code1
	,LocationDetailDEO.mainphone_area_code1
	,LocationDetailDEO.mainphone_subscriber_num1
	,LocationDetailDEO.mainphone_extension1
	,LocationDetailDEO.fax_country_code2
	,LocationDetailDEO.fax_area_code2
	,LocationDetailDEO.fax_subscriber_num2
	,LocationDetailDEO.fax_extension2
	,LocationDetailDEO.otherphone_country_code3
	,LocationDetailDEO.otherphone_area_code3
	,LocationDetailDEO.otherphone_subscriber_num3
	,LocationDetailDEO.otherphone_extension3
	,LocationDetailDEO.ship_to_location_id
	,LocationDetailTranslationDEO.ac_location_code
	,LocationEO.last_updated_by
	,LocationEO.last_update_date
	,LocationEO.CREATED_BY
	,LocationEO.CREATION_DATE
	,LocationDetailDEO.EFFECTIVE_START_DATE
	,LocationDetailDEO.EFFECTIVE_END_DATE
	,LocationDetailDEO.Business_group_id
	,LocationDetailDEO.inventory_organization_id
	,LocationEO.action_occurrence_id
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
	--AND SYSDATE BETWEEN LocationDetailDEO.EFFECTIVE_START_DATE AND LocationDetailDEO.EFFECTIVE_END_DATE
	 
	) HEAD
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.lle_information6
	,AAA.lle_information7
	,AAA.attribute1
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_MWS_INFORMATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) Work_Site
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_REPORTING_INFORMATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) Report
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_VETS_INFORMATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) Veteran
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.lle_information6
	,AAA.lle_information7
	,AAA.lle_information8
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_EEO1_INFORMATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) EEO
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_PA_PSD_INFORMATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) PSD
,(SELECT AAA.location_id
	,AAA.attribute_number1
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_UNEMPLOYMENT_REPORTING'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) UN_EMPLOY
,(SELECT AAA.location_id
	,AAA.lle_information_number1
	,AAA.lle_information_number2
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F AAA
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE AAA.location_id            = BBB.location_id
	AND AAA.lle_information_category = 'HRX_US_VETS_INFORMATION'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) EMP
,SHIP_LOC Ship_LOC
,(SELECT LocationLegislativeEFFDEO.LOCATION_ID
	, LocationLegislativeEFFDEO.LLE_INFORMATION1
	,(
		(SELECT SUBSTR(hl.location_name,1,50)
		FROM fusion.PER_LOCATION_LEG_F pll
		, fusion.hr_locations_all hl
		WHERE(pll.location_id    = hl.location_id
		AND pll.Lle_Information1 = 'Y'
		AND hl.active_status     = 'A'
		AND pll.LLE_INFORMATION_CATEGORY LIKE 'HRX_US_LOC_EEO_VETS_INF')
		AND(hl.location_id = LocationLegislativeEFFDEO.LLE_INFORMATION_NUMBER1
		AND ROWNUM         = 1)
		)) HR_REPORT
	,LocationLegislativeEFFDEO.EFFECTIVE_START_DATE
	,LocationLegislativeEFFDEO.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F LocationLegislativeEFFDEO
	,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE LocationLegislativeEFFDEO.location_id            = BBB.location_id
	AND LocationLegislativeEFFDEO.LLE_INFORMATION_CATEGORY = 'HRX_US_LOC_EEO_VETS_INF'
	AND((BBB.EFFECTIVE_START_DATE BETWEEN LocationLegislativeEFFDEO.EFFECTIVE_START_DATE(+) AND
		LocationLegislativeEFFDEO.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN LocationLegislativeEFFDEO.EFFECTIVE_START_DATE(+) AND
		LocationLegislativeEFFDEO.EFFECTIVE_END_DATE(+)))
	AND SYSDATE BETWEEN BBB.EFFECTIVE_START_DATE AND BBB.EFFECTIVE_END_DATE
	) HR_PROXY
,PAY_INSTALLED_LEGISLATIONS AddressFormatE0
WHERE((HEAD.location_id = Work_Site.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Work_Site.EFFECTIVE_START_DATE(+) AND Work_Site.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Work_Site.EFFECTIVE_START_DATE(+) AND Work_Site.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = Report.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Report.EFFECTIVE_START_DATE(+) AND Report.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Report.EFFECTIVE_START_DATE(+) AND Report.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = Veteran.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Veteran.EFFECTIVE_START_DATE(+) AND Veteran.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Veteran.EFFECTIVE_START_DATE(+) AND Veteran.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = EEO.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN EEO.EFFECTIVE_START_DATE(+) AND EEO.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN EEO.EFFECTIVE_START_DATE(+) AND EEO.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = PSD.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN PSD.EFFECTIVE_START_DATE(+) AND PSD.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN PSD.EFFECTIVE_START_DATE(+) AND PSD.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = UN_EMPLOY.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN UN_EMPLOY.EFFECTIVE_START_DATE(+) AND UN_EMPLOY.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN UN_EMPLOY.EFFECTIVE_START_DATE(+) AND UN_EMPLOY.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = EMP.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN EMP.EFFECTIVE_START_DATE(+) AND EMP.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN EMP.EFFECTIVE_START_DATE(+) AND EMP.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = HR_PROXY.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN HR_PROXY.EFFECTIVE_START_DATE(+) AND HR_PROXY.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN HR_PROXY.EFFECTIVE_START_DATE(+) AND HR_PROXY.EFFECTIVE_END_DATE(+))))
AND (HEAD.LOCATION_ID = Ship_LOC.location_id(+)
	AND HEAD.EFFECTIVE_END_DATE BETWEEN Ship_LOC.EFFECTIVE_START_DATE(+) AND Ship_LOC.EFFECTIVE_END_DATE(+))
AND head.country = AddressFormatE0.LEGISLATION_CODE(+)
AND head.country = 'US'
ORDER BY (CASE
	WHEN EXISTS (SELECT 1 FROM PER_LOCATIONS WHERE LOCATION_ID = Ship_LOC.LOCATION_ID) THEN	1
	ELSE 2 
	END)
,RES_NAME
,RES_CODE
,HEAD.EFFECTIVE_START_DATE