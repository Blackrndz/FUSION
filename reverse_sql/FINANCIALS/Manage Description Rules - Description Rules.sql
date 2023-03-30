/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT (SELECT APPLICATION_NAME
	FROM XLA_SUBLEDGERS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND APPLICATION_ID = descRulesE0.APPLICATION_ID
	) RES_SUBLEDGER_APPLICATION
,descRulesE0.NAME RES_NAME
,descRulesE0.DESCRIPTION_CODE RES_SHORT_NAME
,descRulesE0.DESCRIPTION RES_DESCRIPTION
,DECODE(descRulesE0.ENABLED_FLAG,'Y','Yes','No') RES_STATUS
,descRulesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,descRulesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,descRulesE0.CREATED_BY  RSC_CREATED_BY
,descRulesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_DESCRIPTIONS_VL descRulesE0
ORDER BY 1,2