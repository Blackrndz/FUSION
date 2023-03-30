/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamd $:
* $Date: 2018-03-19 $:
* $HeadURL: $:
* $Id: MManage Accounting Overhead Rules - Rule Revisions $:
* ****************************************************************************
* Description:
* ************************************************************************** */



SELECT
HH.RULE_CODE                                                                   	 RES_RULE_NAME,
DD.VERSION_NUMBER                                                                RES_REVISION_NUMBER,
to_char(DD.EFFECTIVE_START_DATE,'DD-Mon-YYYY')                                    RES_START_DATE,
to_char(DD.EFFECTIVE_END_DATE,'DD-Mon-YYYY')                                      RES_END_DATE,
DD.RATE                                                                          RES_RATE,
decode(DD.POSTED_FLAG,'P','Generated')                                           RES_STATUS
,DD.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DD.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DD.CREATED_BY RSC_CREATED_BY
,DD.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_OVERHEAD_RULE_DETAILS DD
    ,CST_OVERHEAD_RULES HH
WHERE HH.RULE_ID = DD.RULE_ID
Order by RES_RULE_NAME


