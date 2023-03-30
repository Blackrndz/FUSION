/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-11-03 $:
* $HeadURL:  $:
* $Id: Manage Standard Operations - Standard Operations.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=WIS_STANDARD_OPERATIONS_VL
-- RSC_PREREQUISITE_OBJECTS=WIS_WD_OPERATIONS_V

SELECT Distinct
( SELECT ORGANIZATION_CODE 
  FROM INV_ORGANIZATION_DEFINITIONS_V
  WHERE ORGANIZATION_ID = STAN.ORGANIZATION_ID )                                     RES_ORGANIZATION,
STAN.STANDARD_OPERATION_NAME                                                         RES_NAME,
STAN.STANDARD_OPERATION_CODE                                                         RES_CODE,
STAN.STANDARD_OPERATION_DESCRIPTION                                                  RES_DESCRIPTION,
OPER.WORK_CENTER_NAME                                                                RES_WORK_CENTER,
OPER.WORK_CENTER_CODE                                                                RES_WORK_CENTER_CODE,
OPER.WORK_CENTER_DESCRIPTION                                                         RES_WORK_CENTER_DESCRIPTION,
decode(STAN.COUNT_POINT_FLAG,'Y','Yes','No')                                     RES_COUNT_POINT,
decode(STAN.AUTO_TRANSACT_FLAG,'Y','Yes','No')                                   RES_AUTOMATICALLY_TRANSACT,
to_char(STAN.INACTIVE_DATE,'DD-Mon-YYYY')                                  			 RES_INACTIVE_DATE,
decode(STAN.USED_IN_AUTO_WD_FLAG,'Y','Yes','No')                                 RES_DEFAULT_FOR_AUTOMATIC_WORK,
 STAN.LAST_UPDATED_BY 	RSC_LAST_UPDATED_BY
,STAN.LAST_UPDATE_DATE 	RSC_LAST_UPDATE_DATE
,STAN.CREATED_BY 		RSC_CREATED_BY
,STAN.CREATION_DATE 		RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,STAN.ORGANIZATION_ID  RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM  WIS_STANDARD_OPERATIONS_VL  STAN
     ,WIS_WD_OPERATIONS_V  OPER
WHERE STAN.WORK_CENTER_ID   = OPER.WORK_CENTER_ID(+)
--and   nvl(STAN.INACTIVE_DATE,sysdate) >=  sysdate
ORDER BY RES_WORK_CENTER,RES_CODE desc



