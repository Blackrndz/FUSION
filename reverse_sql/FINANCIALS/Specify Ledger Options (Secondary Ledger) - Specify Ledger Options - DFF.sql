/* ****************************************************************************
 * $Revision: 48753 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-08-06 18:52:58 +0700 (Thu, 06 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Secondary%20Ledgers%20-%20Secondary%20Ledgers.sql $:
 * $Id: Manage Secondary Ledgers - Secondary Ledgers.sql 48753 2015-08-06 11:52:58Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_LEDGERS
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT GL2.name RES_PRIMARY_Ledger
, gl.NAME RES_SECONDARY_LEDGER
, gl.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
, gl.ATTRIBUTE1
, gl.ATTRIBUTE2
, gl.ATTRIBUTE3
, gl.ATTRIBUTE4
, gl.ATTRIBUTE5
, gl.ATTRIBUTE6
, gl.ATTRIBUTE7
, gl.ATTRIBUTE8
, gl.ATTRIBUTE9
, gl.ATTRIBUTE10
, gl.ATTRIBUTE11
, gl.ATTRIBUTE12
, gl.ATTRIBUTE13
, gl.ATTRIBUTE14
, gl.ATTRIBUTE15
, gl.ATTRIBUTE_NUMBER1
, gl.ATTRIBUTE_NUMBER2
, gl.ATTRIBUTE_NUMBER3
, gl.ATTRIBUTE_NUMBER4
, gl.ATTRIBUTE_NUMBER5
, TO_CHAR(gl.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(gl.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(gl.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(gl.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(gl.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
, gl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, gl.last_update_date RSC_LAST_UPDATE_DATE
, gl.CREATED_BY RSC_CREATED_BY
, gl.CREATION_DATE RSC_CREATION_DATE
, GL2.LEDGER_ID RSC_LEDGER_ID
, NULL RSC_CHART_OF_ACCOUNTS_ID
, NULL RSC_BUSINESS_UNIT_ID
, NULL RSC_LEGAL_ENTITY_ID
, NULL RSC_ORGANIZATION_ID
, NULL RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM FUSION.GL_LEDGER_CONFIG_DETAILS glcd1
, FUSION.GL_LEDGER_CONFIGURATIONS glc
, FUSION.GL_LEDGERS GL
, FUSION.GL_LEDGERS gl2
, FUSION.FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc1
, FUSION.GL_CALENDARS GlCalendars
, FUSION.XLA_ACCTG_METHODS_VL XLAAMV
, FUSION.GL_LEDGER_RELATIONSHIPS RelationshipEO
WHERE glcd1.OBJECT_TYPE_CODE                         = 'SECONDARY'
AND glcd1.SETUP_STEP_CODE                            = 'NONE'
AND glcd1.CONFIGURATION_ID                           = glc.CONFIGURATION_ID
AND gl.CONFIGURATION_ID                              = glc.CONFIGURATION_ID
AND gl.LEDGER_ID                                     = glcd1.OBJECT_ID
AND gl.CHART_OF_ACCOUNTS_ID                          = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER
AND KeyFlexfieldStructureInstanc1.APPLICATION_ID     = 101
AND KeyFlexfieldStructureInstanc1.KEY_FLEXFIELD_CODE = 'GL#'
AND gl.PERIOD_SET_NAME                               = GlCalendars.PERIOD_SET_NAME
AND GL.ACCOUNTED_PERIOD_TYPE                         = GLCALENDARS.PERIOD_TYPE
AND GL.LEDGER_ID                                     = RELATIONSHIPEO.TARGET_LEDGER_ID
AND GL2.LEDGER_ID                                    = RELATIONSHIPEO.PRIMARY_LEDGER_ID
AND GL2.LEDGER_CATEGORY_CODE                         = 'PRIMARY'
AND RELATIONSHIPEO.target_ledger_category_code       = 'SECONDARY'
AND GL.SLA_ACCOUNTING_METHOD_CODE                    = XLAAMV.ACCOUNTING_METHOD_CODE(+)
AND GL.SLA_ACCOUNTING_METHOD_TYPE                    = XLAAMV.ACCOUNTING_METHOD_TYPE_CODE(+)
AND(NVL(gl.RET_EARN_CODE_COMBINATION_ID, - 1)        > 0)
AND(gl.ATTRIBUTE_CATEGORY                           IS NOT NULL
OR gl.ATTRIBUTE1                                    IS NOT NULL
OR gl.ATTRIBUTE2                                    IS NOT NULL
OR gl.ATTRIBUTE3                                    IS NOT NULL
OR gl.ATTRIBUTE4                                    IS NOT NULL
OR gl.ATTRIBUTE5                                    IS NOT NULL
OR gl.ATTRIBUTE6                                    IS NOT NULL
OR gl.ATTRIBUTE7                                    IS NOT NULL
OR gl.ATTRIBUTE8                                    IS NOT NULL
OR gl.ATTRIBUTE9                                    IS NOT NULL
OR gl.ATTRIBUTE10                                   IS NOT NULL
OR gl.ATTRIBUTE11                                   IS NOT NULL
OR gl.ATTRIBUTE12                                   IS NOT NULL
OR gl.ATTRIBUTE13                                   IS NOT NULL
OR gl.ATTRIBUTE14                                   IS NOT NULL
OR gl.ATTRIBUTE15                                   IS NOT NULL
OR gl.ATTRIBUTE_NUMBER1                             IS NOT NULL
OR gl.ATTRIBUTE_NUMBER2                             IS NOT NULL
OR gl.ATTRIBUTE_NUMBER3                             IS NOT NULL
OR gl.ATTRIBUTE_NUMBER4                             IS NOT NULL
OR gl.ATTRIBUTE_NUMBER5                             IS NOT NULL
OR gl.ATTRIBUTE_DATE1                               IS NOT NULL
OR gl.ATTRIBUTE_DATE2                               IS NOT NULL
OR gl.ATTRIBUTE_DATE3                               IS NOT NULL
OR gl.ATTRIBUTE_DATE4                               IS NOT NULL
OR gl.ATTRIBUTE_DATE5                               IS NOT NULL)
ORDER BY RES_PRIMARY_LEDGER
, RES_SECONDARY_LEDGER