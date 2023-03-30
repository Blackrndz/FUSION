/* ****************************************************************************
 * $Revision: 79268 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-08-30 17:59:15 +0700 (Tue, 30 Aug 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organizations%20-%20General.sql $:
 * $Id: Manage Inventory Organizations - General.sql 79268 2022-08-30 10:59:15Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_ORG_PARAMETERS 

SELECT OrganizationParameterEO.ORGANIZATION_CODE  AS RES_ORGANIZATION
,OrgClassificationPEO.CLASSIFICATION_NAME AS RES_CLASSIFICATION
,(SELECT SCHEDULE_NAME
	FROM ZMM_SR_SCHEDULES_VL
	WHERE SCHEDULE_ID = OrganizationParameterEO.SCHEDULE_ID
	) AS RES_SCHEDULE
,(SELECT name || DECODE(timezone_code, 'Europe/London', 'London - Greenwich Mean Time (GMT)'
	, 'Pacific/Pago_Pago' , 'Pago Pago - Samao Time (ST)'
	, 'Pacific/Honolulu' , 'Honolulu - Hawaii Time (HT)'
	, 'America/Anchorage' , 'Alaska Time (AKT)'
	, 'America/Los_Angeles' , 'Los Angeles - Pacific Time (PT)'
	, 'America/Phoenix' , 'Phoenix - Mountain Time (MT)'
	, 'America/Denver' , 'Denver - Mountain Time (MT)'
	, 'America/Regina' , 'Regina - Central Time (CT)'
	, 'America/Chicago' , 'Chicago - Central Time (CT)'
	, 'America/New_York' , 'New York - Eastern Time (ET)'
	, 'America/Halifax' , 'Canada Atlantic Time (AT)'
	, 'America/Santiago' , 'Santiago - Chile Time (CLT)'
	, 'America/Godthab' , 'Godthab - Western Greenland Time (WGT)'
	, 'America/Sao_Paulo' , 'Sao Paulo - Brasilia Time (BRT)'
	, 'America/St_Johns' , 'St Johns - Newfoundland Time (NT)'
	, 'America/Noronha' , 'Noronha - Fernando de Noronha Time (FNT)'
	, 'Europe/Belgrade' , 'Belgrade - Central European Time (CET)'
	, 'Africa/Tunis' , 'Tunis - Central European Time (CET)'
	, 'Europe/Warsaw' , 'Warsaw - Central European Time (CET)'
	, 'Asia/Amman' , 'Amman - Eastern European Time (EET)'
	, 'Asia/Beirut' , 'Beirut - Eastern European Time (EET)'
	, 'Africa/Cairo' , 'Cairo - Egypt Time (ET)'
	, 'Asia/Damascus' , 'Damascus - Eastern European Time (EET)'
	, 'Europe/Istanbul' , 'Istanbul - Eastern European Time (EET)'
	, 'Asia/Jerusalem' , 'Jerusalem - Israel Time (IT)'
	, 'Africa/Tripoli' , 'Tripoli - Eastern European Time (EET)'
	, 'Asia/Baghdad' , 'Baghdad - Arabia Time (AT)'
	, 'Europe/Moscow' , 'Moscow - Moscow Time (MSK)'
	, 'Asia/Riyadh' , 'Riyadh - Arabia European Time (AT)'
	, 'Asia/Tehran' , 'Tehran - Iran Time (IRT)'
	, 'Asia/Dubai' , 'Dubai - Gulf Time (GT)'
	, 'Asia/Yekaterinburg' , 'Yekaterinburg - Yekaterinburg Time (YEKT)'
	, 'Asia/Calcutta' , 'Calcutta - India Time (IT)'
	, 'Asia/Kathmandu' , 'Kathmandu - Nepal Time (NPT)'
	, 'Asia/Almaty' , 'Almaty - Alma*Ata Time (ALMT)'
	, 'Asia/Dhaka' , 'Dhaka - Bangladesh Time (BDT)'
	, 'Asia/Bangkok' , 'Bangkok - Indochina Time (ICT)'
	, 'Asia/Krasnoyarsk' , 'Krasnoyarsk - Krasnoyarsk Time (KRAT)'
	, 'Asia/Hong_Kong' , 'Hong Kong - Hong Kong Time (HKT)'
	, 'Asia/Irkutsk' , 'Irkutsk - Irkutsk Time (IRKT)'
	, 'Asia/Tokyo' , 'Tokyo - Japan Time (JT)'
	, 'Asia/Yakutsk' , 'Yakutsk - Yakutsk Time (YAKT)'
	, 'Australia/Adelaide' , 'Adelaide - Central Time (South Australia) (CT)'
	, 'Australia/Darwin' , 'Darwin - Central Time (Northern Territory) (CT)'
	, 'Australia/Brisbane' , 'Brisbane - Eastern Time (Queensland) (ET)'
	, 'Australia/Hobart' , 'Hobart - Eastern Time (Tasmasnia) (ET)'
	, 'Australia/Sydney' , 'Sydney - Eastern Time (New South Wales) (ET)'
	, 'Asia/Magadan' , 'Magadan - Magadan Time (MAGT)'
	, 'Pacific/Auckland' , 'Auckland - New Zealand Time (NZT)'
	, 'Asia/Kamchatka' , 'Kamchatka - Petropavlovsk-Kamchatski Time (PETT)'
	, 'Coordinated Universal Time (UTC)'
	)
	FROM (SELECT  timezone_code
		, '(UTC' ||DECODE(timezone_code, 'Europe/London', '+00:00'
	, 'Pacific/Pago_Pago' , '-11:00'
	, 'Pacific/Honolulu' , '-10:00'
	, 'America/Anchorage' , '-09:00'
	, 'America/Los_Angeles' , '-08:00'
	, 'America/Phoenix' , '-07:00'
	, 'America/Denver' , '-07:00'
	, 'America/Regina' , '-06:00'
	, 'America/Chicago' , '-06:00'
	, 'America/New_York' , '-05:00'
	, 'America/Halifax' , '-04:00'
	, 'America/Santiago' , '-04:00'
	, 'America/Godthab' , '-03:00'
	, 'America/Sao_Paulo' , '-03:00'
	, 'America/St_Johns' , '-03:30'
	, 'America/Noronha' , '-02:00'
	, 'Europe/Belgrade' , '+01:00'
	, 'Africa/Tunis' , '+01:00'
	, 'Europe/Warsaw' , '+01:00'
	, 'Asia/Amman' , '+02:00'
	, 'Asia/Beirut' , '+02:00'
	, 'Africa/Cairo' , '+02:00'
	, 'Asia/Damascus' , '+02:00'
	, 'Europe/Istanbul' , '+02:00'
	, 'Asia/Jerusalem' , '+02:00'
	, 'Africa/Tripoli' , '+02:00'
	, 'Asia/Baghdad' , '+03:00'
	, 'Europe/Moscow' , '+03:00'
	, 'Asia/Riyadh' , '+03:00'
	, 'Asia/Tehran' , '+03:30'
	, 'Asia/Dubai' , '+04:00'
	, 'Asia/Yekaterinburg' , '+05:00'
	--, 'Asia/Calcutta' , 'Calcutta - India Time (IT)'
	, 'Asia/Kathmandu' , '+05:45'
	, 'Asia/Almaty' , '+06:00'
	, 'Asia/Dhaka' , '+06:00'
	, 'Asia/Bangkok' , '+07:00'
	, 'Asia/Krasnoyarsk' , '+07:00'
	, 'Asia/Hong_Kong' , '+08:00'
	, 'Asia/Irkutsk' , '+08:00'
	, 'Asia/Tokyo' , '+09:00'
	, 'Asia/Yakutsk' , '+09:00'
	, 'Australia/Adelaide' , '+09:30'
	, 'Australia/Darwin' , '+09:30'
	, 'Australia/Brisbane' , '+10:00'
	, 'Australia/Hobart' , '+10:00'
	, 'Australia/Sydney' , '+10:00'
	, 'Asia/Magadan' , '+11:00'
	, 'Pacific/Auckland' , '+12:00'
	, 'Asia/Kamchatka' , '+12:00'
	, '+00:00'
	) || ') ' name
		FROM FND_TIMEZONES_VL
		WHERE enabled_flag = 'Y') QRSLT 
	WHERE timezone_code = NVL(OrganizationParameterEO.TIMEZONE_CODE,'UTC')
	)  AS RES_TIME_ZONE
,(SELECT DISTINCT name
	FROM HR_ORGANIZATION_V
	WHERE ORGANIZATION_ID = OrganizationParameterEO.MASTER_ORGANIZATION_ID
	)                                         AS RES_ITEM_MASTER_ORGANIZATION
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'ORA_RCS_ITEM_GROUPING_BHVR'
	AND lookup_code = OrganizationParameterEO.ITEM_GROUPING_CODE
	) RES_ITEM_GROUPING_BEHAVIOR
,(SELECT DISTINCT name
	FROM HR_ORGANIZATION_V
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND ORGANIZATION_ID = OrganizationParameterEO.ITEM_DEFINITION_ORG_ID 
	) RES_ITEM_DEFINITION_ORGANIZATI

,OrganizationParameterEO.STARTING_REVISION AS RES_STARTING_REVISION
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'RCS_LOCATION_CONTROL'
	AND lookup_code   = OrganizationParameterEO.STOCK_LOCATOR_CONTROL_CODE
	) AS RES_LOCATOR_CONTROL
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'INV_YES_NO_NUMERIC'
	AND lookup_code = OrganizationParameterEO.PROJECT_REFERENCE_ENABLED) RES_ENABLE_INVENTORY_TRACKING_
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.ENFORCE_LOCATOR_ALIS_UNQ_FLAG,'N')
	) AS RES_ENFORCE_LOCATOR_ALIAS_UNIQ
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'INV_YES_NO_NUMERIC'
	AND lookup_code   = NVL(OrganizationParameterEO.NEGATIVE_INV_RECEIPT_CODE,2)
	) AS RES_ALLOW_NEGATIVE_BALANCES
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.ALLOW_NEG_ONHAND_CC_TXNS,'N')
	) AS RES_ALLOW_NEGATIVE_ON_HAND_TRA
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.FIFO_ORIG_RCPT_DATE_FLAG,'N')
	) AS RES_USE_ORIGINAL_RECEIPT_DATE
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.ROUND_REORDER_QTY_FLAG,'N')
	) AS RES_ROUND_REORDER_QUANTITY
,DECODE(OrganizationParameterEO.FILL_KILL_TRANSFER_ORDERS_FLAG,'Y','Yes','No') RES_AUTOMATICALLY_CANCEL_TRANS
,DECODE(OrganizationParameterEO.USE_CUR_ITEM_COST_FLAG,'Y','Yes','No') RES_USE_CURRENT_ITEM_COST
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.MFG_PLANT_FLAG,'N')
	) AS RES_ORGANIZATION_IS_A_MANUFACT
,DECODE(OrganizationParameterEO.EAM_ENABLED_FLAG,'Y','Yes','No') RES_ORGANIZATION_PERFORMS_MAIN
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'ORA_RCS_INTEGRATED_SYSTEMS'
	AND lookup_code   = OrganizationParameterEO.INTEGRATED_SYSTEM_CODE) RES_INTEGRATED_SYSTEM_TYPE
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.CONTRACT_MFG_FLAG,'N')
	)                                            AS RES_ORGANIZATION_REPRESENTS_A_
,(select PARTY_NAME from HZ_PARTIES HzParties
	,POZ_SUPPLIERS PozSuppliers
	WHERE HzParties.PARTY_ID = PozSuppliers.PARTY_ID
	AND PozSuppliers.VENDOR_ID = OrganizationParameterEO.SUPPLIER_ID
	)          AS RES_SUPPLIER
,(SELECT PARTY_SITE_NAME
	FROM POZ_SUPPLIER_SITES_ALL_M PozSupplierSitesAll
	,HZ_PARTY_SITES HzPartySites
	WHERE HzPartySites.PARTY_SITE_ID = PozSupplierSitesAll.PARTY_SITE_ID
	AND PozSupplierSitesAll.VENDOR_SITE_ID = OrganizationParameterEO.SUPPLIER_SITE_ID
	AND PozSupplierSitesAll.VENDOR_ID = OrganizationParameterEO.SUPPLIER_ID
	)     AS RES_SUPPLIER_SITE
,DECODE(OrganizationParameterEO.INTERNAL_CUSTOMER_FLAG,'Y','Yes','No') RES_ORGANIZATION_IS_ASSOCIATED
,(SELECT PARTY_NAME FROM HZ_PARTIES WHERE PARTY_ID = OrganizationParameterEO.PARTY_ID) RES_CUSTOMER_NAME
,OrganizationParameterEO.CUSTOMER_ACCOUNT_NUMBER RES_ACCOUNT_NUMBER
,OrganizationParameterEO.PICK_SLIP_BATCH_SIZE AS RES_PICK_SLIP_BATCH_SIZE
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'INV_REPLENISHMENT_GROUP'
	AND lookup_code   = OrganizationParameterEO.REPLNSH_MOVE_ORDER_GROUPING
	) AS RES_REPLENISHMENT_MOVEMENT_REQ
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.AUTO_DEL_ALLOC_FLAG,'N')
	) AS RES_AUTOMATICALLY_DELETE_PICKS
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.FILL_KILL_MOVE_ORDER_FLAG,'N')
	) AS RES_CLOSE_MOVEMENT_REQUEST_LIN

,OrganizationParameterEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,OrganizationParameterEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,OrganizationParameterEO.CREATED_BY RSC_CREATED_BY
,OrganizationParameterEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,OrganizationParameterEO.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,OrganizationParameterEO.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ORG_PARAMETERS OrganizationParameterEO
,HR_ORGANIZATION_V InventoryOrganizationEO
,HR_ORG_CLASSIFICATIONS_VL OrgClassificationPEO
WHERE InventoryOrganizationEO.ORGANIZATION_ID   = OrganizationParameterEO.ORGANIZATION_ID
AND InventoryOrganizationEO.CLASSIFICATION_CODE = 'INV'
AND OrganizationParameterEO.INVENTORY_FLAG      = 'Y'
AND InventoryOrganizationEO.CLASSIFICATION_CODE = OrgClassificationPEO.CLASSIFICATION_CODE
AND SYSDATE BETWEEN InventoryOrganizationEO.EFFECTIVE_START_DATE AND InventoryOrganizationEO.EFFECTIVE_END_DATE
ORDER BY OrganizationParameterEO.CREATION_DATE