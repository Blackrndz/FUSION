/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organizations%20-%20Lot%20Serial%20Number%20and%20Packing%20Unit.sql $:
 * $Id: Manage Inventory Organizations - Lot Serial Number and Packing Unit.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT OrganizationParameterEO.ORGANIZATION_CODE AS RES_ORGANIZATION
,OrgClassificationPEO.CLASSIFICATION_NAME AS RES_CLASSIFICATION
,(SELECT MEANING
	FROM fnd_lookups
	WHERE lookup_type = 'INV_LOT_UNIQUENESS'
	AND lookup_code   = OrganizationParameterEO.LOT_NUMBER_UNIQUENESS
	) AS RES_LOT_CONTROL_UNIQUENESS
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'INV_LOT_GENERATION'
	AND lookup_code   = OrganizationParameterEO.LOT_NUMBER_GENERATION
	) AS RES_LOT_CONTROL_GENERATION
,(SELECT MEANING
	FROM fnd_lookups
	WHERE lookup_type = 'INV_ALLOW_DIFF_LOT_STATUS'
	AND lookup_code   = OrganizationParameterEO.ALLOW_DIFFERENT_STATUS
	) AS RES_ALLOW_DIFFERENT_LOT_STATUS
,(SELECT MEANING
	FROM fnd_lookups
	WHERE lookup_type = 'INV_AUTOCREATE_LOT_UOM_CONV'
	AND lookup_code   = OrganizationParameterEO.CREATE_LOT_UOM_CONVERSION
	)                                             AS RES_AUTOMATICALLY_CREATE_LOT_U
,OrganizationParameterEO.AUTO_LOT_ALPHA_PREFIX AS RES_LOT_GENERATION_PREFIX
,OrganizationParameterEO.LOT_NUMBER_LENGTH     AS RES_LOT_GENERATION_TOTAL_LENGT
,DECODE(OrganizationParameterEO.LOT_NUMBER_ZERO_PADDING,NULL,'No','Yes') RES_LOT_GENERATION_ZERO_PAD_SU
,(SELECT MEANING
	FROM fnd_lookups
	WHERE lookup_type = 'INV_CHILD_LOT_CONTROL_GEN'
	AND lookup_code   = OrganizationParameterEO.PARENT_CHILD_GENERATION_FLAG
	)                                               AS RES_CHILD_LOT_CONTROL_GENERATI
,OrganizationParameterEO.CHILD_LOT_ALPHA_PREFIX  AS RES_CHILD_LOT_CONTROL_PREFIX
,OrganizationParameterEO.CHILD_LOT_NUMBER_LENGTH AS RES_CHILD_LOT_CONTROL_TOTAL_LE
,DECODE(OrganizationParameterEO.CHILD_LOT_ZERO_PADDING_FLAG, 'Y', 'Yes', 'No') RES_CHILD_LOT_CONTROL_ZERO_PAD
,DECODE(OrganizationParameterEO.COPY_LOT_ATTRIBUTE_FLAG, 'Y', 'Yes', 'No') RES_COPY_LOT_ATTRIBUTES
,DECODE(OrganizationParameterEO.CHILD_LOT_VALIDATION_FLAG, 'Y', 'Yes', 'No') RES_FORMAT_VALIDATION
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'INV_SERIAL_NUMBER_TYPE'
	AND lookup_code   = OrganizationParameterEO.SERIAL_NUMBER_TYPE
	) AS RES_SERIAL_NUMBER_GENERATION_U
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'INV_SERIAL_GENERATION'
	AND lookup_code   = OrganizationParameterEO.SERIAL_NUMBER_GENERATION
	)                                                AS RES_SERIAL_NUMBER_GENERATION_G
,OrganizationParameterEO.AUTO_SERIAL_ALPHA_PREFIX AS RES_SERIAL_NUMBER_GENERATION_P
,OrganizationParameterEO.START_AUTO_SERIAL_NUMBER AS RES_STARTING_SERIAL_NUMBER
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = OrganizationParameterEO.ALLOCATE_SERIAL_FLAG
	)                                        AS RES_SYSTEM_SELECTS_SERIAL_NUMB
,OrganizationParameterEO.TOTAL_LPN_LENGTH AS RES_PACKING_UNIT_GENERATION_TO
,OrganizationParameterEO.LPN_PREFIX       AS RES_PACKING_UNIT_GENERATION_PR
,(SELECT MEANING
	FROM hcm_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(OrganizationParameterEO.UCC_128_SUFFIX_FLAG,'N')
	)                                           AS RES_GS1_128
,OrganizationParameterEO.LPN_STARTING_NUMBER AS RES_STARTING_PACKING_UNIT
,OrganizationParameterEO.LPN_SUFFIX          AS RES_SUFFIX
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
AND InventoryOrganizationEO.CLASSIFICATION_CODE  = OrgClassificationPEO.CLASSIFICATION_CODE
AND SYSDATE BETWEEN InventoryOrganizationEO.EFFECTIVE_START_DATE AND InventoryOrganizationEO.EFFECTIVE_END_DATE
ORDER BY InventoryOrganizationEO.name