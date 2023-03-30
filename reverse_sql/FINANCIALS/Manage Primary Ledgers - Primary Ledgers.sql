/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Primary%20Ledgers%20-%20Primary%20Ledgers.sql $:
 * $Id: Manage Primary Ledgers - Primary Ledgers.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT
  QRSLT.OBJECT_NAME RES_NAME,
  QRSLT.DESCRIPTION RES_DESCRIPTION,
  QRSLT.name RES_CHART_OF_ACCOUNTS,
  QRSLT.USER_PERIOD_SET_NAME RES_ACCOUNTING_CALENDAR,
  QRSLT.CURRENCY_CODE RES_CURRENCY,
  QRSLT.SLAM RES_ACCOUNTING_METHOD
  ,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,QRSLT.CREATED_BY  RSC_CREATED_BY
  ,QRSLT.CREATION_DATE  RSC_CREATION_DATE
  ,QRSLT.LEDGER_ID RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
  (SELECT glcd1.*,
    gl.DESCRIPTION,
    KeyFlexfieldStructureInstanc1.NAME,
    GlCalendars.USER_PERIOD_SET_NAME,
    CURRENCYEO.CURRENCY_CODE ||' - ' ||CURRENCYEO.name CURRENCY_CODE,
    xlaamv.NAME SLAM,
    glc.COMPLETION_STATUS_CODE,
	gl.LEDGER_ID
  FROM FUSION.GL_LEDGER_CONFIG_DETAILS glcd1,
    FUSION.GL_LEDGER_CONFIGURATIONS glc,
    FUSION.GL_LEDGERS gl,
    FUSION.FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc1,
    FUSION.GL_CALENDARS GlCalendars,
    FUSION.XLA_ACCTG_METHODS_VL xlaamv,
	FUSION.FND_CURRENCIES_VL CURRENCYEO
  WHERE glcd1.OBJECT_TYPE_CODE                         = 'PRIMARY'
  AND glcd1.SETUP_STEP_CODE                            = 'NONE'
  AND glcd1.CONFIGURATION_ID                           = glc.CONFIGURATION_ID
  AND gl.CONFIGURATION_ID                              = glc.CONFIGURATION_ID
  AND gl.LEDGER_ID                                     = glcd1.OBJECT_ID
  AND gl.CHART_OF_ACCOUNTS_ID                          = KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER
  AND KeyFlexfieldStructureInstanc1.APPLICATION_ID     = 101
  AND KeyFlexfieldStructureInstanc1.KEY_FLEXFIELD_CODE = 'GL#'  
  AND gl.PERIOD_SET_NAME                               = GlCalendars.PERIOD_SET_NAME
  AND gl.ACCOUNTED_PERIOD_TYPE                         = GlCalendars.PERIOD_TYPE
  and gl.CURRENCY_CODE  							   = CURRENCYEO.CURRENCY_CODE
  AND GL.SLA_ACCOUNTING_METHOD_CODE                    = XLAAMV.ACCOUNTING_METHOD_CODE(+)
  AND GL.SLA_ACCOUNTING_METHOD_TYPE                    = XLAAMV.ACCOUNTING_METHOD_TYPE_CODE(+)
  ) QRSLT
ORDER BY OBJECT_NAME