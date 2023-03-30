/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organizations%20-%20Basic%20Information.sql $:
 * $Id: Manage Inventory Organizations - Basic Information.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT OrganizationParameterEO.ORGANIZATION_CODE  AS RES_ORGANIZATION
,(
	CASE
		WHEN EXISTS
			(SELECT NULL
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			--WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'INV'
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE IN ('ENTERPRISE','HCM_DIVISION','DEPARTMENT','FUN_BUSINESS_UNIT')
			AND InventoryOrganizationEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND EXISTS
				(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
				WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'INV'
				AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
				AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
				)
			)
		THEN 'Select an existing organization'
		ELSE 'Create new'
	END)                                                             AS RES_CREATE_ORGANIZATION
,InventoryOrganizationEO.name        AS RES_NAME

,OrgClassificationPEO.CLASSIFICATION_NAME AS RES_CLASSIFICATION
,'Inventory management'                    AS RES_USAGE
,(SELECT bu_name
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = OrganizationParameterEO.BUSINESS_UNIT_ID
	) AS RES_MANAGEMENT_BUSINESS_UNIT
,(SELECT name
	FROM gl_ledgers
	WHERE LEDGER_ID =
		(SELECT PRIMARY_LEDGER_ID
		FROM FUN_ALL_BUSINESS_UNITS_V
		WHERE BU_ID = OrganizationParameterEO.BUSINESS_UNIT_ID
		)
	) AS RES_PRIMARY_LEDGER
,(SELECT name
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = OrganizationParameterEO.LEGAL_ENTITY_ID
	) AS RES_LEGAL_ENTITY
,(SELECT bu_name
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = OrganizationParameterEO.PROFIT_CENTER_BU_ID
	) AS RES_PROFIT_CENTER_BUSINESS_UNI
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'ACTIVE_INACTIVE'
	AND lookup_code   = InventoryOrganizationEO.STATUS
	) AS RES_STATUS
,LocationE0.LOCATION_NAME AS RES_LOCATION_NAME
,LocationE0.INTERNAL_LOCATION_CODE AS RES_LOCATION_CODE
,(SELECT DISTINCT per_address_format.format_address(p_address_line_1 => addf.ADDRESS_LINE_1,p_address_line_2 =>
		addf.ADDRESS_LINE_2,p_address_line_3 => addf.ADDRESS_LINE_3,p_address_line_4 => addf.ADDRESS_LINE_4,p_city =>
		addf.TOWN_OR_CITY,p_postal_code => addf.POSTAL_CODE,p_state => addf.REGION_2,p_province => addf.REGION_3,p_county =>
		addf.REGION_1,p_floor_number => addf.FLOOR_NUMBER,p_building => addf.BUILDING,p_country => addf.COUNTRY,
		p_addl_address_attribute1 => addf.ADDL_ADDRESS_ATTRIBUTE1,p_addl_address_attribute2 => addf.ADDL_ADDRESS_ATTRIBUTE2,
		p_addl_address_attribute3 => addf.ADDL_ADDRESS_ATTRIBUTE3,p_addl_address_attribute4 => addf.ADDL_ADDRESS_ATTRIBUTE4,
		p_addl_address_attribute5 => addf.ADDL_ADDRESS_ATTRIBUTE5,p_style_code => 'POSTAL_ADDR',p_line_break => ' ',
		p_hcm_style_code => 'HCM_ADDR',p_address_quality => 3)
	FROM PER_ADDRESSES_F addf
	WHERE EFFECTIVE_END_DATE >= SYSDATE
	AND ADDRESS_ID = 
		(SELECT MAIN_ADDRESS_ID
		FROM PER_LOCATION_DETAILS_F
		WHERE LOCATION_ID = InventoryOrganizationEO.LOCATION_ID
		AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		)
	) AS RES_ADDRESS
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'INTL_EXTL'
	AND lookup_code   = InventoryOrganizationEO.INTERNAL_EXTERNAL_FLAG
	)                                             AS RES_INTERNAL_OR_EXTERNAL
,InventoryOrganizationEO.INTERNAL_ADDRESS_LINE AS RES_INTERNAL_ADDRESS_LINE
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
,(SELECT LOCATION_ID, LOCATION_NAME, INTERNAL_LOCATION_CODE, COUNTRY
	FROM HR_LOCATIONS_ALL_F_VL  
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE) LocationE0
WHERE InventoryOrganizationEO.ORGANIZATION_ID   = OrganizationParameterEO.ORGANIZATION_ID
AND InventoryOrganizationEO.CLASSIFICATION_CODE = 'INV'
AND OrganizationParameterEO.INVENTORY_FLAG      = 'Y'
AND InventoryOrganizationEO.CLASSIFICATION_CODE  = OrgClassificationPEO.CLASSIFICATION_CODE
AND SYSDATE BETWEEN InventoryOrganizationEO.EFFECTIVE_START_DATE AND InventoryOrganizationEO.EFFECTIVE_END_DATE
AND InventoryOrganizationEO.LOCATION_ID = LocationE0.LOCATION_ID(+)
ORDER BY InventoryOrganizationEO.name
,RES_CREATE_ORGANIZATION