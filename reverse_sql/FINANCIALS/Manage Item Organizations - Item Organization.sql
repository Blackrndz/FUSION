/* ****************************************************************************
 * $Revision: 78938 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-07-07 11:21:50 +0700 (Thu, 07 Jul 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Item%20Organizations%20-%20Item%20Organization.sql $:
 * $Id: Manage Item Organizations - Item Organization.sql 78938 2022-07-07 04:21:50Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=INV_ORG_PARAMETERS
 
SELECT (
	CASE
		WHEN EXISTS
			(SELECT NULL
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			--WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'INV'
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE IN ('ENTERPRISE','HCM_DIVISION','DEPARTMENT','FUN_BUSINESS_UNIT')
			AND OrgOrganizationDefinitionEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
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
	END)                                                                           						RES_CREATE_ORGANIZATION,
  
  OrgOrganizationDefinitionEO.ORGANIZATION_NAME                                 						RES_NAME,
  OrgOrganizationDefinitionEO.ORGANIZATION_CODE                                 						RES_ORGANIZATION,
  NULL RES_CLASSIFICATION,
  (select LookupPEO.MEANING
  FROM FND_LOOKUPS LookupPEO
  WHERE LookupPEO.LOOKUP_TYPE = 'RCS_ORGANIZATION_USAGE' 
  and  LookupPEO.LOOKUP_CODE = OrgOrganizationDefinitionEO.INVENTORY_FLAG  
  )     																								RES_USAGE,
  OrgOrganizationDefinitionEO.BUSINESS_UNIT_NAME                                          				RES_MANAGEMENT_BUSINESS_UNIT,
  (select GlLedgers.NAME from GL_LEDGERS GlLedgers  
  where GlLedgers.LEDGER_ID = OrgOrganizationDefinitionEO.SET_OF_BOOKS_ID
  )                                                                                      				RES_PRIMARY_LEDGER,
  XleEntityProfiles.NAME                                                                    			RES_LEGAL_ENTITY,
  (select BusinessUnitPEO.BU_NAME from FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
   where  BusinessUnitPEO.BU_ID  =  OrgOrganizationDefinitionEO.PROFIT_CENTER_BU_ID
   )                                                                                  					RES_PROFIT_CENTER_BUSINESS_UNI,
  decode(INVENTORY_ENABLED_FLAG,'Y','Active','Inactive')                                    			RES_STATUS,
   (select distinct LOCATION_name from  HR_LOCATIONS_ALL_F_VL LocationDPEO
   where   LocationDPEO.LOCATION_ID  = OrgOrganizationDefinitionEO.LOCATION_ID
   AND SYSDATE BETWEEN LocationDPEO.EFFECTIVE_START_DATE AND LocationDPEO.EFFECTIVE_END_DATE
  )                                                                            							RES_LOCATION_NAME,
  (select distinct INTERNAL_LOCATION_CODE from  HR_LOCATIONS_ALL_F_VL LocationDPEO
   where   LocationDPEO.LOCATION_ID  = OrgOrganizationDefinitionEO.LOCATION_ID 
      AND SYSDATE BETWEEN LocationDPEO.EFFECTIVE_START_DATE AND LocationDPEO.EFFECTIVE_END_DATE
  )                                                    													RES_LOCATION_CODE,
  (SELECT DISTINCT per_address_format.format_address(p_address_line_1 => addf.ADDRESS_LINE_1,p_address_line_2 =>
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
		WHERE LOCATION_ID = OrgOrganizationDefinitionEO.LOCATION_ID
		AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		)
  )                                   																	RES_ADDRESS,
    
 (select  HrLookupEO.MEANING FROM HR_LOOKUPS HrLookupEO
  where HrLookupEO.LOOKUP_TYPE = 'INTL_EXTL'
  and   HrLookupEO.LOOKUP_CODE  = OrganizationUnitDEO.INTERNAL_EXTERNAL_FLAG  
  )                                            															RES_INTERNAL_OR_EXTERNAL,
  OrganizationUnitDEO.INTERNAL_ADDRESS_LINE                                                             RES_INTERNAL_ADDRESS_LINE
,(SELECT ORGANIZATION_NAME
	FROM INV_ORGANIZATION_DEFINITIONS_V
	WHERE ORGANIZATION_ID = MP.MASTER_ORGANIZATION_ID
	AND SYSDATE BETWEEN USER_DEFINITION_ENABLE_DATE AND DISABLE_DATE
	) RES_ITEM_MASTER_ORGANIZATION
,(select LookupPEO.MEANING
  FROM FND_LOOKUPS LookupPEO
  WHERE LookupPEO.LOOKUP_TYPE = 'ORA_RCS_ITEM_GROUPING_BHVR' 
  and  LookupPEO.LOOKUP_CODE =  MP.ITEM_GROUPING_CODE
  )   RES_ITEM_GROUPING_BEHAVIOR
,(SELECT ORGANIZATION_NAME
	FROM INV_ORGANIZATION_DEFINITIONS_V
	WHERE ORGANIZATION_ID = MP.ITEM_DEFINITION_ORG_ID 
	AND SYSDATE BETWEEN USER_DEFINITION_ENABLE_DATE AND DISABLE_DATE
	) RES_ITEM_DEFINITION_ORGANIZATI
,MP.STARTING_REVISION RES_STARTING_REVISION
,MP.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MP.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MP.CREATED_BY RSC_CREATED_BY
,MP.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,MP.BUSINESS_UNIT_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,(CASE
	WHEN EXISTS
		(SELECT DISTINCT MASTER_ORGANIZATION_ID
			FROM INV_ORG_PARAMETERS
			WHERE MASTER_ORGANIZATION_ID = OrgOrganizationDefinitionEO.ORGANIZATION_ID)
	THEN NULL
	ELSE MP.ORGANIZATION_ID
	END) RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ORGANIZATION_DEFINITIONS_V OrgOrganizationDefinitionEO
,XLE_ENTITY_PROFILES XleEntityProfiles
,HR_ALL_ORGANIZATION_UNITS_F OrganizationUnitDEO
,INV_ORG_PARAMETERS MP
WHERE OrgOrganizationDefinitionEO.LEGAL_ENTITY = XleEntityProfiles.LEGAL_ENTITY_ID(+)
AND OrgOrganizationDefinitionEO.ORGANIZATION_ID = OrganizationUnitDEO.ORGANIZATION_ID(+)
AND OrgOrganizationDefinitionEO.INVENTORY_FLAG ='N'
AND  OrgOrganizationDefinitionEO.ORGANIZATION_ID   =  MP.ORGANIZATION_ID
ORDER BY OrgOrganizationDefinitionEO.ORGANIZATION_NAME,RES_CREATE_ORGANIZATION
