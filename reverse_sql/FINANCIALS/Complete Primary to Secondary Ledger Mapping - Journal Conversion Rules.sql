/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT QRSLT.PRIMARY_LEDGER RES_PRIMARY_LEDGER ,
QRSLT.TARGET_LEDGER_NAME RES_SECONDARY_LEDGER ,
QRSLT.USER_JE_SOURCE_NAME RES_JOURNAL_SOURCE,
(SELECT USER_JE_CATEGORY_NAME
	FROM GL_JE_CATEGORIES_VL
	WHERE JE_CATEGORY_NAME = QRSLT.JE_CATEGORY_NAME
	) RES_JOURNAL_CATEGORY,
QRSLT.INCLUDE_FLAG RES_TRANSFER_JOURNALS_TO_THIS_
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,QRSLT.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from 
(SELECT  
  GlLedgerRelationships.TARGET_CURRENCY_CODE,
  GlLedgerRelationships.TARGET_LEDGER_NAME,
  GlLedgerRelationships.RELATIONSHIP_TYPE_CODE,
  GlLedgerRelationships.ALC_DEFAULT_CONV_RATE_TYPE,
  KeyFlexfieldStructureInstanc1.NAME AS NAME2,
  PRIMARY_LEDGER.TARGET_LEDGER_NAME PRIMARY_LEDGER ,
  FLEXFIELDDATAEO.JE_SOURCE_NAME ,
  FLEXFIELDDATAEO.JE_CATEGORY_NAME ,
  DECODE(FLEXFIELDDATAEO.INCLUDE_FLAG,'Y','Yes','N','No')  INCLUDE_FLAG ,
  FLEXFIELDDATAEO.LAST_UPDATE_DATE,
  FLEXFIELDDATAEO.LAST_UPDATED_BY,  
  FLEXFIELDDATAEO.CREATED_BY,
  FLEXFIELDDATAEO.CREATION_DATE,
  GLJESOURCE.USER_JE_SOURCE_NAME,
  CoaMappingEO.NAME AS NAME1,
  PRIMARY_LEDGER.TARGET_CURRENCY_CODE PRIMARY_CURRENCY_CODE,
  PRIMARY_LEDGER.NAME2 PRIMARY_COA,
  PRIMARY_LEDGER.PRIMARY_LEDGER_ID
FROM GL_LEDGER_RELATIONSHIPS GlLedgerRelationships,
  GL_LEDGERS GLLEDGERS, 
  FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1,
  gl_je_inclusion_rules flexfielddataeo,
  GL_JE_SOURCES_VL GLJESOURCE,
  GL_COA_MAPPINGS COAMAPPINGEO,
    (SELECT GlLedgerRelationships.TARGET_LEDGER_ID,
    GlLedgerRelationships.TARGET_LEDGER_NAME,
    GlLedgerRelationships.RELATIONSHIP_ID,  
    GlLedgerRelationships.PRIMARY_LEDGER_ID,
    GlLedgerRelationships.SOURCE_LEDGER_ID,
    GLLEDGERRELATIONSHIPS.TARGET_CURRENCY_CODE ,
	KeyFlexfieldStructureInstanc1.NAME AS NAME2
    FROM GL_LEDGER_CONFIG_DETAILS glcd1,
    GL_LEDGER_CONFIGURATIONS glc,
    GL_LEDGERS GL,
    FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1 ,
    GL_LEDGER_RELATIONSHIPS GLLEDGERRELATIONSHIPS
  WHERE GLLEDGERRELATIONSHIPS.target_ledger_category_code = 'PRIMARY'
  and glcd1.OBJECT_TYPE_CODE                         = 'PRIMARY'
  AND glcd1.SETUP_STEP_CODE                            = 'NONE'
  AND glcd1.CONFIGURATION_ID                           = glc.CONFIGURATION_ID
  AND gl.CONFIGURATION_ID                              = glc.CONFIGURATION_ID
  AND gl.LEDGER_ID                                     = glcd1.OBJECT_ID
  AND gl.CHART_OF_ACCOUNTS_ID                          = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER
  AND KeyFlexfieldStructureInstanc1.APPLICATION_ID     = 101
  and KEYFLEXFIELDSTRUCTUREINSTANC1.KEY_FLEXFIELD_CODE = 'GL#'  
  and GLLEDGERRELATIONSHIPS.PRIMARY_LEDGER_ID            = GLLEDGERRELATIONSHIPS.SOURCE_LEDGER_ID
  and GlLedgerRelationships.target_LEDGER_ID         = gl.LEDGER_ID  
    ) primary_ledger
WHERE GlLedgerRelationships.SL_COA_MAPPING_ID           = CoaMappingEO.coa_mapping_ID(+)
and (GlLedgerRelationships.target_LEDGER_ID         = GlLedgers.LEDGER_ID)
AND GlLedgerRelationships.application_id              =101
AND GlLedgerRelationships.TARGET_LEDGER_CATEGORY_CODE ='SECONDARY'
AND (KeyFlexfieldStructureInstanc1.application_id     =101
AND KeyFlexfieldStructureInstanc1.key_flexfield_code  ='GL#'
AND GlLedgers.CHART_OF_ACCOUNTS_ID                    = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER)
AND primary_ledger.TARGET_LEDGER_ID                    = GlLedgerRelationships.PRIMARY_LEDGER_ID
and GlLedgerRelationships.GL_JE_CONVERSION_SET_ID= flexfielddataeo.je_rule_set_id
and FLEXFIELDDATAEO.JE_SOURCE_NAME = GLJESOURCE.JE_SOURCE_NAME
) qrslt
where QRSLT.RELATIONSHIP_TYPE_CODE != 'ADJUST'
and ((QRSLT.PRIMARY_COA              = QRSLT.NAME2
		OR(QRSLT.PRIMARY_COA                 != QRSLT.NAME2
		AND QRSLT.NAME1                      IS NOT NULL))
		AND((QRSLT.PRIMARY_CURRENCY_CODE      = QRSLT.TARGET_CURRENCY_CODE)
		OR(QRSLT.PRIMARY_CURRENCY_CODE       != QRSLT.TARGET_CURRENCY_CODE
		AND QRSLT.ALC_DEFAULT_CONV_RATE_TYPE IS NOT NULL)))
ORDER BY res_primary_ledger,res_secondary_ledger,RES_JOURNAL_SOURCE