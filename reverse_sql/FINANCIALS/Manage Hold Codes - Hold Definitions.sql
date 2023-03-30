/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Hold Codes - Hold Definitions.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT
  HOLD_CODE                                                                     RES_CODE,
  HOLD_NAME                                                                     RES_NAME,
  HOLD_DESCRIPTION                                                              RES_DESCRIPTION,
  to_char(EFFECTIVE_START_DATE,'DD-Mon-YYYY')                                   RES_START_DATE,
  to_char(EFFECTIVE_END_DATE,'DD-Mon-YYYY')                                                            RES_END_DATE,
  decode(GENERAL_HOLD_FLAG,'Y','Yes','No')                                                             RES_HOLD_ALL_SERVICES,
  (select SetIdSetPEO.SET_CODE
   FROM FND_SETID_SETS_VL SetIdSetPEO
   where SetIdSetPEO.SET_ID    = HoldCodeEO.SET_ID   
   )                                                                            RES_SET
,HoldCodeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,HoldCodeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,HoldCodeEO.CREATED_BY RSC_CREATED_BY
,HoldCodeEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_HOLD_CODES_VL HoldCodeEO
ORDER BY HoldCodeEO.HOLD_CODE

