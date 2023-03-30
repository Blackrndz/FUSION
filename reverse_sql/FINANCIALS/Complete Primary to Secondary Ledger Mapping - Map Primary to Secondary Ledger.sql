/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Map%20Primary%20to%20Secondary%20Ledger.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Map Primary to Secondary Ledger.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT QRSLT.PRIMARY_LEDGER RES_PRIMARY_LEDGER ,
QRSLT.TARGET_LEDGER_NAME RES_SECONDARY_LEDGER ,
(case 
	when QRSLT.PRIMARY_COA != QRSLT.NAME2 then
		QRSLT.name1 
	else
		null
end
) RES_CHART_OF_ACCOUNTS_MAPPING,
(case 
	when QRSLT.PRIMARY_CURRENCY_CODE != QRSLT.TARGET_CURRENCY_CODE then
		QRSLT.PRIMARY_LEDGER 
	else
		null
end
) RES_SOURCE_REPRESENTATION,
(case 
	when QRSLT.PRIMARY_CURRENCY_CODE != QRSLT.TARGET_CURRENCY_CODE then
		(SELECT USER_CONVERSION_TYPE
		FROM GL_DAILY_CONVERSION_TYPES
		WHERE CONVERSION_TYPE = QRSLT.ALC_DEFAULT_CONV_RATE_TYPE )
	else
		null
end
) RES_DEFAULT_CONVERSION_RATE_TY,
(case 
	when QRSLT.PRIMARY_CURRENCY_CODE != QRSLT.TARGET_CURRENCY_CODE then
		decode(QRSLT.ALC_INHERIT_CONVERSION_TYPE,'Y','Yes','N','No')
	else
		null
end
) RES_RETAIN_TRANSACTION_RATE_TY,
(case 
	when QRSLT.PRIMARY_CURRENCY_CODE != QRSLT.TARGET_CURRENCY_CODE then
		decode(QRSLT.ALC_NO_RATE_ACTION_CODE,'FIND_RATE','Use last rate','REPORT_ERROR','Report error')
	else
		null
end
) RES_MISSING_CONVERSION_RATE,
(case 
	when QRSLT.PRIMARY_CURRENCY_CODE != QRSLT.TARGET_CURRENCY_CODE then
		QRSLT.ALC_MAX_DAYS_ROLL_RATE
	else
		null
end
) RES_NUMBER_OF_DAYS_TO_FIND_LAS,
decode(qrslt.automatic_post_flag,'Y','Yes','N','No') res_post_journals_automaticall ,
decode(qrslt.inherit_creation_user_flag,'Y','Yes','N','No') res_retain_journal_creator_fro 
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
(SELECT distinct
  GlLedgerRelationships.TARGET_CURRENCY_CODE,
  GlLedgerRelationships.TARGET_LEDGER_NAME,
  GlLedgerRelationships.TARGET_LEDGER_ID,
  GlLedgerRelationships.INHERIT_CREATION_USER_FLAG,
  GlLedgerRelationships.LAST_UPDATE_DATE,
  GlLedgerRelationships.LAST_UPDATED_BY,  
  GlLedgerRelationships.CREATED_BY,
  GlLedgerRelationships.CREATION_DATE,
  GlLedgerRelationships.AUTOMATIC_POST_FLAG,
  GlLedgerRelationships.ALC_DEFAULT_CONV_RATE_TYPE,
  GlLedgerRelationships.ALC_NO_RATE_ACTION_CODE,
  GlLedgerRelationships.ALC_MAX_DAYS_ROLL_RATE,
  GlLedgerRelationships.ALC_INHERIT_CONVERSION_TYPE,
  KeyFlexfieldStructureInstanc1.NAME AS NAME2,
  CoaMappingEO.NAME AS NAME1,
  PRIMARY_LEDGER.TARGET_LEDGER_NAME PRIMARY_LEDGER  ,
  PRIMARY_LEDGER.TARGET_CURRENCY_CODE PRIMARY_CURRENCY_CODE ,
  PRIMARY_LEDGER.NAME2 PRIMARY_COA,  
  PRIMARY_LEDGER.PRIMARY_LEDGER_ID
FROM FUSION.GL_LEDGER_RELATIONSHIPS GlLedgerRelationships,
  FUSION.GL_LEDGERS GLLEDGERS,
  FUSION.GL_CALENDARS GLCALENDARS,
  FUSION.GL_LOOKUPS RELTYPELOOKUP,
  FUSION.GL_LOOKUPS LEDGERCOMPLSTATUSLOOKUP,
  FUSION.FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1,
  FUSION.GL_COA_MAPPINGS COAMAPPINGEO,
  FUSION.GL_DAILY_CONVERSION_TYPES DEFCONVTYPE ,
  FUSION.GL_JE_INCLUSION_RULES FLEXFIELDDATAEO ,  
  (SELECT GlLedgerRelationships.TARGET_LEDGER_ID,
    GlLedgerRelationships.TARGET_LEDGER_NAME,
    GlLedgerRelationships.RELATIONSHIP_ID,  
    GlLedgerRelationships.PRIMARY_LEDGER_ID,
    GlLedgerRelationships.SOURCE_LEDGER_ID,
    GLLEDGERRELATIONSHIPS.TARGET_CURRENCY_CODE ,
	KeyFlexfieldStructureInstanc1.NAME AS NAME2
    FROM FUSION.GL_LEDGER_CONFIG_DETAILS glcd1,
    FUSION.GL_LEDGER_CONFIGURATIONS glc,
    FUSION.GL_LEDGERS GL,
    FUSION.FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1 ,
    FUSION.GL_LEDGER_RELATIONSHIPS GLLEDGERRELATIONSHIPS
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
WHERE (GlLedgerRelationships.target_LEDGER_ID         = GlLedgers.LEDGER_ID)
AND GlLedgerRelationships.application_id              =101
AND GlLedgerRelationships.TARGET_LEDGER_CATEGORY_CODE ='SECONDARY'
AND (GlLedgerRelationships.RELATIONSHIP_TYPE_CODE     = RelTypeLookup.LOOKUP_CODE
AND RelTypeLookup.LOOKUP_TYPE(+)                      = 'GL_ASF_SL_RELATIONSHIP_LEVEL')
AND ((GlLedgers.COMPLETION_STATUS_CODE                = LedgerComplStatusLookup.LOOKUP_CODE(+)
AND LedgerComplStatusLookup.LOOKUP_TYPE(+)            = 'GL_ASF_CFG_STATUS_CODES')
AND (KeyFlexfieldStructureInstanc1.application_id     =101
AND KeyFlexfieldStructureInstanc1.key_flexfield_code  ='GL#'
AND GlLedgers.CHART_OF_ACCOUNTS_ID                    = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER))
AND ((GlLedgers.PERIOD_SET_NAME                       = GlCalendars.PERIOD_SET_NAME)
AND (GlLedgers.ACCOUNTED_PERIOD_TYPE                  = GlCalendars.PERIOD_TYPE) )
AND (GlLedgerRelationships.SL_COA_MAPPING_ID           = CoaMappingEO.coa_mapping_ID(+))
AND (glledgerrelationships.alc_default_conv_rate_type = defconvtype.conversion_type(+))
AND primary_ledger.TARGET_LEDGER_ID                    = GlLedgerRelationships.PRIMARY_LEDGER_ID
) QRSLT 
where  ((QRSLT.PRIMARY_COA              = QRSLT.NAME2
		OR(QRSLT.PRIMARY_COA                 != QRSLT.NAME2
		AND QRSLT.NAME1                      IS NOT NULL))
		AND((QRSLT.PRIMARY_CURRENCY_CODE      = QRSLT.TARGET_CURRENCY_CODE)
		OR(QRSLT.PRIMARY_CURRENCY_CODE       != QRSLT.TARGET_CURRENCY_CODE
		AND QRSLT.ALC_DEFAULT_CONV_RATE_TYPE IS NOT NULL)))
order by RES_PRIMARY_LEDGER,RES_SECONDARY_LEDGER