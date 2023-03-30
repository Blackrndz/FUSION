/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Map%20Primary%20to%20Secondary%20Ledger.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Map Primary to Secondary Ledger.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_LEDGER_RELATIONSHIPS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT QRSLT.PRIMARY_LEDGER RES_PRIMARY_LEDGER
,QRSLT.TARGET_LEDGER_NAME RES_SECONDARY_LEDGER
,QRSLT.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,QRSLT.ATTRIBUTE1
,QRSLT.ATTRIBUTE2
,QRSLT.ATTRIBUTE3
,QRSLT.ATTRIBUTE4
,QRSLT.ATTRIBUTE5
,QRSLT.ATTRIBUTE6
,QRSLT.ATTRIBUTE7
,QRSLT.ATTRIBUTE8
,QRSLT.ATTRIBUTE9
,QRSLT.ATTRIBUTE10
,QRSLT.ATTRIBUTE11
,QRSLT.ATTRIBUTE12
,QRSLT.ATTRIBUTE13
,QRSLT.ATTRIBUTE14
,QRSLT.ATTRIBUTE15
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,QRSLT.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT DISTINCT GlLedgerRelationships.TARGET_CURRENCY_CODE
	,GlLedgerRelationships.TARGET_LEDGER_NAME
	,GlLedgerRelationships.TARGET_LEDGER_ID
	,GlLedgerRelationships.INHERIT_CREATION_USER_FLAG
	,GlLedgerRelationships.LAST_UPDATE_DATE
	,GlLedgerRelationships.LAST_UPDATED_BY
	,GlLedgerRelationships.ATTRIBUTE_CATEGORY
	,GlLedgerRelationships.ATTRIBUTE1
	,GlLedgerRelationships.ATTRIBUTE2
	,GlLedgerRelationships.ATTRIBUTE3
	,GlLedgerRelationships.ATTRIBUTE4
	,GlLedgerRelationships.ATTRIBUTE5
	,GlLedgerRelationships.ATTRIBUTE6
	,GlLedgerRelationships.ATTRIBUTE7
	,GlLedgerRelationships.ATTRIBUTE8
	,GlLedgerRelationships.ATTRIBUTE9
	,GlLedgerRelationships.ATTRIBUTE10
	,GlLedgerRelationships.ATTRIBUTE11
	,GlLedgerRelationships.ATTRIBUTE12
	,GlLedgerRelationships.ATTRIBUTE13
	,GlLedgerRelationships.ATTRIBUTE14
	,GlLedgerRelationships.ATTRIBUTE15
	,GlLedgerRelationships.ORG_ID
	,GlLedgerRelationships.CREATED_BY
	,GlLedgerRelationships.CREATION_DATE
	,GlLedgerRelationships.AUTOMATIC_POST_FLAG
	,GlLedgerRelationships.ALC_DEFAULT_CONV_RATE_TYPE
	,GlLedgerRelationships.ALC_NO_RATE_ACTION_CODE
	,GlLedgerRelationships.ALC_MAX_DAYS_ROLL_RATE
	,GlLedgerRelationships.ALC_INHERIT_CONVERSION_TYPE
	,KeyFlexfieldStructureInstanc1.NAME AS NAME2
	,CoaMappingEO.NAME                  AS NAME1
	,PRIMARY_LEDGER.TARGET_LEDGER_NAME PRIMARY_LEDGER
	,PRIMARY_LEDGER.TARGET_CURRENCY_CODE PRIMARY_CURRENCY_CODE
	,PRIMARY_LEDGER.NAME2 PRIMARY_COA
	,PRIMARY_LEDGER.PRIMARY_LEDGER_ID
	FROM FUSION.GL_LEDGER_RELATIONSHIPS GlLedgerRelationships
	,FUSION.GL_LEDGERS GLLEDGERS
	,FUSION.GL_CALENDARS GLCALENDARS
	,FUSION.GL_LOOKUPS RELTYPELOOKUP
	,FUSION.GL_LOOKUPS LEDGERCOMPLSTATUSLOOKUP
	,FUSION.FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1
	,FUSION.GL_COA_MAPPINGS COAMAPPINGEO
	,FUSION.GL_DAILY_CONVERSION_TYPES DEFCONVTYPE
	,FUSION.GL_JE_INCLUSION_RULES FLEXFIELDDATAEO
	,(SELECT GlLedgerRelationships.TARGET_LEDGER_ID
		,GlLedgerRelationships.TARGET_LEDGER_NAME
		,GlLedgerRelationships.RELATIONSHIP_ID
		,GlLedgerRelationships.PRIMARY_LEDGER_ID
		,GlLedgerRelationships.SOURCE_LEDGER_ID
		,GLLEDGERRELATIONSHIPS.TARGET_CURRENCY_CODE
		,KeyFlexfieldStructureInstanc1.NAME AS NAME2
		FROM FUSION.GL_LEDGER_CONFIG_DETAILS glcd1
		,FUSION.GL_LEDGER_CONFIGURATIONS glc
		,FUSION.GL_LEDGERS GL
		,FUSION.FND_KF_STR_INSTANCES_VL KEYFLEXFIELDSTRUCTUREINSTANC1
		,FUSION.GL_LEDGER_RELATIONSHIPS GLLEDGERRELATIONSHIPS
		WHERE GLLEDGERRELATIONSHIPS.target_ledger_category_code = 'PRIMARY'
		AND glcd1.OBJECT_TYPE_CODE                              = 'PRIMARY'
		AND glcd1.SETUP_STEP_CODE                               = 'NONE'
		AND glcd1.CONFIGURATION_ID                              = glc.CONFIGURATION_ID
		AND gl.CONFIGURATION_ID                                 = glc.CONFIGURATION_ID
		AND gl.LEDGER_ID                                        = glcd1.OBJECT_ID
		AND gl.CHART_OF_ACCOUNTS_ID                             = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER
		AND KeyFlexfieldStructureInstanc1.APPLICATION_ID        = 101
		AND KEYFLEXFIELDSTRUCTUREINSTANC1.KEY_FLEXFIELD_CODE    = 'GL#'
		AND GLLEDGERRELATIONSHIPS.PRIMARY_LEDGER_ID             = GLLEDGERRELATIONSHIPS.SOURCE_LEDGER_ID
		AND GlLedgerRelationships.target_LEDGER_ID              = gl.LEDGER_ID
		) primary_ledger
	WHERE(GlLedgerRelationships.target_LEDGER_ID          = GlLedgers.LEDGER_ID)
	AND GlLedgerRelationships.application_id              = 101
	AND GlLedgerRelationships.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY'
	AND(GlLedgerRelationships.RELATIONSHIP_TYPE_CODE      = RelTypeLookup.LOOKUP_CODE
	AND RelTypeLookup.LOOKUP_TYPE(+)                      = 'GL_ASF_SL_RELATIONSHIP_LEVEL')
	AND((GlLedgers.COMPLETION_STATUS_CODE                 = LedgerComplStatusLookup.LOOKUP_CODE(+)
	AND LedgerComplStatusLookup.LOOKUP_TYPE(+)            = 'GL_ASF_CFG_STATUS_CODES')
	AND(KeyFlexfieldStructureInstanc1.application_id      = 101
	AND KeyFlexfieldStructureInstanc1.key_flexfield_code  = 'GL#'
	AND GlLedgers.CHART_OF_ACCOUNTS_ID                    = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER))
	AND((GlLedgers.PERIOD_SET_NAME                        = GlCalendars.PERIOD_SET_NAME)
	AND(GlLedgers.ACCOUNTED_PERIOD_TYPE                   = GlCalendars.PERIOD_TYPE))
	AND(GlLedgerRelationships.SL_COA_MAPPING_ID           = CoaMappingEO.coa_mapping_ID(+))
	AND(glledgerrelationships.alc_default_conv_rate_type  = defconvtype.conversion_type(+))
	AND primary_ledger.TARGET_LEDGER_ID                   = GlLedgerRelationships.PRIMARY_LEDGER_ID
	) QRSLT
WHERE((QRSLT.PRIMARY_COA              = QRSLT.NAME2
OR(QRSLT.PRIMARY_COA                 != QRSLT.NAME2
AND QRSLT.NAME1                      IS NOT NULL))
AND((QRSLT.PRIMARY_CURRENCY_CODE      = QRSLT.TARGET_CURRENCY_CODE)
OR(QRSLT.PRIMARY_CURRENCY_CODE       != QRSLT.TARGET_CURRENCY_CODE
AND QRSLT.ALC_DEFAULT_CONV_RATE_TYPE IS NOT NULL)))
AND(QRSLT.ATTRIBUTE_CATEGORY         IS NOT NULL
OR QRSLT.ATTRIBUTE1                  IS NOT NULL
OR QRSLT.ATTRIBUTE2                  IS NOT NULL
OR QRSLT.ATTRIBUTE3                  IS NOT NULL
OR QRSLT.ATTRIBUTE4                  IS NOT NULL
OR QRSLT.ATTRIBUTE5                  IS NOT NULL
OR QRSLT.ATTRIBUTE6                  IS NOT NULL
OR QRSLT.ATTRIBUTE7                  IS NOT NULL
OR QRSLT.ATTRIBUTE8                  IS NOT NULL
OR QRSLT.ATTRIBUTE9                  IS NOT NULL
OR QRSLT.ATTRIBUTE10                 IS NOT NULL
OR QRSLT.ATTRIBUTE11                 IS NOT NULL
OR QRSLT.ATTRIBUTE12                 IS NOT NULL
OR QRSLT.ATTRIBUTE13                 IS NOT NULL
OR QRSLT.ATTRIBUTE14                 IS NOT NULL
OR QRSLT.ATTRIBUTE15                 IS NOT NULL)
ORDER BY RES_PRIMARY_LEDGER
,RES_SECONDARY_LEDGER