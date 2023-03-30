/* ****************************************************************************
 * $Revision: 53883 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-24 15:01:53 +0700 (Thu, 24 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Specify%20Ledger%20Options%20(Primary%20Ledger)%20-%20Specify%20Ledger%20Options.sql $:
 * $Id: Specify Ledger Options (Primary Ledger) - Specify Ledger Options.sql 53883 2016-03-24 08:01:53Z pisan.jariyasettachok $:
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

SELECT gl.NAME RES_PRIMARY_LEDGER,
  gl.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE ,
  gl.ATTRIBUTE1 ,
  gl.ATTRIBUTE2 ,
  gl.ATTRIBUTE3 ,
  gl.ATTRIBUTE4 ,
  gl.ATTRIBUTE5 ,
  gl.ATTRIBUTE6 ,
  gl.ATTRIBUTE7 ,
  gl.ATTRIBUTE8 ,
  gl.ATTRIBUTE9 ,
  gl.ATTRIBUTE10 ,
  gl.ATTRIBUTE11 ,
  gl.ATTRIBUTE12 ,
  gl.ATTRIBUTE13 ,
  gl.ATTRIBUTE14 ,
  gl.ATTRIBUTE15 ,
  gl.ATTRIBUTE_NUMBER1 ,
  gl.ATTRIBUTE_NUMBER2 ,
  gl.ATTRIBUTE_NUMBER3 ,
  gl.ATTRIBUTE_NUMBER4 ,
  gl.ATTRIBUTE_NUMBER5 ,
  TO_CHAR(gl.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1,
  TO_CHAR(gl.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2,
  TO_CHAR(gl.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3,
  TO_CHAR(gl.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4,
  TO_CHAR(gl.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5,
  gl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY,
  gl.last_update_date RSC_LAST_UPDATE_DATE ,
  gl.CREATED_BY RSC_CREATED_BY ,
  gl.CREATION_DATE RSC_CREATION_DATE ,
  gl.LEDGER_ID RSC_LEDGER_ID ,
  gl.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID ,
  NULL RSC_BUSINESS_UNIT_ID ,
  NULL RSC_LEGAL_ENTITY_ID ,
  NULL RSC_ORGANIZATION_ID ,
  NULL RSC_BUSINESS_GROUP_ID ,
  NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUSION.GL_LEDGER_CONFIG_DETAILS glcd1,
  FUSION.GL_LEDGER_CONFIGURATIONS glc,
  FUSION.GL_LEDGERS gl,
  FUSION.FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc1,
  FUSION.GL_CALENDARS GlCalendars,
  FUSION.XLA_ACCTG_METHODS_VL xlaamv ,
  FUSION.FND_LANGUAGES_VL LanguagePEO ,
  FUSION.GL_DAILY_CONVERSION_TYPES GlDailyConversionTypes,
  FUSION.GL_DAILY_CONVERSION_TYPES GlDailyConversionTypesPrdAvg ,
  FUSION.GL_AUTOREV_CRITERIA_SETS AutorevCriteriaSetPEO,
  FUSION.GL_TRANSACTION_CALENDAR TransactionCalendarPEO ,
  FUSION.GL_SUSPENSE_ACCOUNTS SA
WHERE glcd1.OBJECT_TYPE_CODE                         = 'PRIMARY'
AND glcd1.SETUP_STEP_CODE                            = 'NONE'
AND glcd1.CONFIGURATION_ID                           = glc.CONFIGURATION_ID
AND gl.CONFIGURATION_ID                              = glc.CONFIGURATION_ID
AND gl.LEDGER_ID                                     = glcd1.OBJECT_ID
AND gl.CHART_OF_ACCOUNTS_ID                          = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER
AND KeyFlexfieldStructureInstanc1.APPLICATION_ID     = 101
AND KeyFlexfieldStructureInstanc1.KEY_FLEXFIELD_CODE = 'GL#'
AND KeyFlexfieldStructureInstanc1.ENABLED_FLAG       = 'Y'
AND gl.PERIOD_SET_NAME                               = GlCalendars.PERIOD_SET_NAME
AND gl.ACCOUNTED_PERIOD_TYPE                         = GlCalendars.PERIOD_TYPE
AND GL.SLA_ACCOUNTING_METHOD_CODE                    = XLAAMV.ACCOUNTING_METHOD_CODE(+)
AND GL.SLA_ACCOUNTING_METHOD_TYPE                    = XLAAMV.ACCOUNTING_METHOD_TYPE_CODE(+)
AND gl.SLA_DESCRIPTION_LANGUAGE                      = LanguagePEO.LANGUAGE_CODE(+)
AND (Gl.PERIOD_END_RATE_TYPE                         = GlDailyConversionTypes.CONVERSION_TYPE (+))
AND (Gl.PERIOD_AVERAGE_RATE_TYPE                     = GlDailyConversionTypesPrdAvg.CONVERSION_TYPE (+))
AND (Gl.CRITERIA_SET_ID                              = AutorevCriteriaSetPEO.CRITERIA_SET_ID(+))
AND (gl.TRANSACTION_CALENDAR_ID                      = TransactionCalendarPEO.TRANSACTION_CALENDAR_ID(+))
AND (gl.LEDGER_ID                                    = sa.LEDGER_ID(+))
AND (NVL(gl.RET_EARN_CODE_COMBINATION_ID,-1)         > 0)
AND (gl.ATTRIBUTE_CATEGORY IS NOT NULL OR
  gl.ATTRIBUTE1 IS NOT NULL OR
  gl.ATTRIBUTE2 IS NOT NULL OR
  gl.ATTRIBUTE3 IS NOT NULL OR
  gl.ATTRIBUTE4 IS NOT NULL OR
  gl.ATTRIBUTE5 IS NOT NULL OR
  gl.ATTRIBUTE6 IS NOT NULL OR
  gl.ATTRIBUTE7 IS NOT NULL OR
  gl.ATTRIBUTE8 IS NOT NULL OR
  gl.ATTRIBUTE9 IS NOT NULL OR
  gl.ATTRIBUTE10 IS NOT NULL OR
  gl.ATTRIBUTE11 IS NOT NULL OR
  gl.ATTRIBUTE12 IS NOT NULL OR
  gl.ATTRIBUTE13 IS NOT NULL OR
  gl.ATTRIBUTE14 IS NOT NULL OR
  gl.ATTRIBUTE15 IS NOT NULL OR
  gl.ATTRIBUTE_NUMBER1 IS NOT NULL OR
  gl.ATTRIBUTE_NUMBER2 IS NOT NULL OR
  gl.ATTRIBUTE_NUMBER3 IS NOT NULL OR
  gl.ATTRIBUTE_NUMBER4 IS NOT NULL OR
  gl.ATTRIBUTE_NUMBER5 IS NOT NULL OR
  gl.ATTRIBUTE_DATE1 IS NOT NULL OR
  gl.ATTRIBUTE_DATE2 IS NOT NULL OR
  gl.ATTRIBUTE_DATE3 IS NOT NULL OR
  gl.ATTRIBUTE_DATE4 IS NOT NULL OR
  gl.ATTRIBUTE_DATE5 IS NOT NULL)
ORDER BY gl.NAME