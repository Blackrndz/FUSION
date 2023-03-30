/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Default%20Item%20Class%20-%20Item%20Management.sql $:
 * $Id: Manage Default Item Class - Item Management.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT ItemClassPEO.ITEM_CLASS_CODE RES_INTERNAL_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_ITEM_NUM_GEN_METHOD'
	AND LOOKUP_CODE = ItemClassPEO.ITEM_NUM_GEN_METHOD
	) RES_ITEM_NUMBER_GENERATION_MET
,EntityAutoGenMetadataEO.STARTING_NUMBER RES_ITEM_NUMBER_GENERATION_M_0
,EntityAutoGenMetadataEO.PREFIX RES_ITEM_NUMBER_GENERATION_M_1
,EntityAutoGenMetadataEO.INCREMENT_BY RES_ITEM_NUMBER_GENERATION_M_2
,EntityAutoGenMetadataEO.SUFFIX RES_ITEM_NUMBER_GENERATION_M_3
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_EGP_CTO_NUM_GEN_METHOD'
	AND LOOKUP_CODE = ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD
	) RES_CONFIGURED_ITEM_NUMBER_GEN
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		EntityAutoGenMetadataE1.STARTING_NUMBER
	END) RES_CONFIGURED_ITEM_NUMBER_G_4
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'ORA_EGP_CFG_ITEM_NUM_GEN_AFFIX'
			AND LOOKUP_CODE = EntityAutoGenMetadataE1.PREFIX_TYPE)
	END) RES_CONFIGURED_ITEM_NUMBER_G_5
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		EntityAutoGenMetadataE1.PREFIX
	END) RES_CONFIGURED_ITEM_NUMBER_G_6
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		EntityAutoGenMetadataE1.INCREMENT_BY
	END) RES_CONFIGURED_ITEM_NUMBER_G_7
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'ORA_EGP_CFG_ITEM_NUM_GEN_AFFIX'
			AND LOOKUP_CODE = EntityAutoGenMetadataE1.SUFFIX_TYPE)
	END) RES_CONFIGURED_ITEM_NUMBER_G_8
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		EntityAutoGenMetadataE1.SUFFIX
	END) RES_CONFIGURED_ITEM_NUMBER_G_9
,(CASE
	WHEN ItemClassPEO.CFG_ITEM_NUM_GEN_METHOD <> 'NONE' THEN
		(SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'ORA_EGP_CFG_ITEM_NUM_GEN_DEL'
			AND LOOKUP_CODE = EntityAutoGenMetadataE1.DELIMITER)
	END) RES_CONFIGURED_ITEM_NUMBER__10
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_ITEM_NUM_GEN_METHOD'
	AND LOOKUP_CODE = ItemClassPEO.ITEM_DESC_GEN_METHOD
	) RES_ITEM_DESCRIPTION_GENERATIO
,NVL(EntityAutoGenMetadataEO.LAST_UPDATED_BY,EntityAutoGenMetadataE1.LAST_UPDATED_BY) RSC_LAST_UPDATED_BY
,NVL(EntityAutoGenMetadataEO.LAST_UPDATE_DATE,EntityAutoGenMetadataE1.LAST_UPDATE_DATE) RSC_LAST_UPDATE_DATE
,NVL(EntityAutoGenMetadataEO.CREATED_BY,EntityAutoGenMetadataE1.CREATED_BY) RSC_CREATED_BY
,NVL(EntityAutoGenMetadataEO.CREATION_DATE,EntityAutoGenMetadataE1.CREATION_DATE) RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,(SELECT *
	FROM EGO_ENTITY_AUTO_GEN_METADATA
	WHERE OBJECT_NAME = 'EGP_IC'
	) EntityAutoGenMetadataEO
,(SELECT *
	FROM EGO_ENTITY_AUTO_GEN_METADATA
	WHERE OBJECT_NAME = 'EGP_CI'
	) EntityAutoGenMetadataE1
WHERE ItemClassPEO.PARENT_ITEM_CLASS_ID NOT IN (SELECT ITEM_CLASS_ID FROM EGP_ITEM_CLASSES_VL)
AND ItemClassPEO.ITEM_CLASS_ID = EntityAutoGenMetadataEO.OBJECT_ID1(+)
AND ItemClassPEO.ITEM_CLASS_ID = EntityAutoGenMetadataE1.OBJECT_ID1(+)
ORDER BY 1