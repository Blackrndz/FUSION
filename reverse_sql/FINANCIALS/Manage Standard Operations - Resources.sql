/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-11-08 $:
* $HeadURL:  $:
* $Id: Manage Standard Operations - Resources.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=WIS_STANDARD_OPERATIONS_VL
-- RSC_PREREQUISITE_OBJECTS=WIS_STD_OPERATION_RESOURCES
-- RSC_PREREQUISITE_OBJECTS=WIS_RESOURCES_VL


SELECT Distinct 
( SELECT ORGANIZATION_CODE 
  FROM INV_ORGANIZATION_DEFINITIONS_V
  WHERE ORGANIZATION_ID = STAN.ORGANIZATION_ID )                                                 	RES_ORGANIZATION,
STAN.STANDARD_OPERATION_NAME                                                         				RES_NAME,
RSC.RESOURCE_SEQ_NUMBER                                                        						RES_SEQUENCE,
AAA.RESOURCE_NAME                                               									RES_RESOURCE,
RSC.ASSIGNED_UNITS                                                            						RES_UNITS_ASSIGNED,
(
select meaning
from fnd_lookups
where  LOOKUP_TYPE  = 'ORA_MSC_BASIS_TYPE'
and LOOKUP_CODE   = RSC.BASIS_TYPE        
)                                                    												RES_BASIS,
RSC.USAGE_RATE                                                     									RES_USAGE,
RSC.INVERSE_USAGE_RATE                                     											RES_INVERSE_USAGE,
( SELECT UNIT_OF_MEASURE
  FROM INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
  WHERE UnitOfMeasurePEO.UOM_CODE = RSC.UOM_CODE 
  )																									RES_UOM,
decode(RSC.SCHEDULE_TYPE,'YES','Yes','NO','No')                                 					RES_SCHEDULED,
decode(RSC.PRINCIPAL_FLAG,'Y','Yes','No')                                 						RES_PRINCIPAL,
(
select meaning
from fnd_lookups
where  LOOKUP_TYPE  = 'PJF_PROJECT_NUMBER_ENTRY'
and LOOKUP_CODE   =  RSC.CHARGE_TYPE	
)																									RES_CHARGE_TYPE,
AAA.RESOURCE_CODE																					RES_CODE,
(  select MEANING
  from fnd_lookups
  where LOOKUP_TYPE = 'ORA_WIS_RESOURCE_ACTIVITY'
  and  lookup_code =  RSC.RESOURCE_ACTIVITY_CODE	
)																									RES_ACTIVITY,
decode(AAA.COSTED_FLAG,'Y','Yes','No')															RES_COSTING_ENABLED,
TO_CHAR(AAA.INACTIVE_DATE,'DD-Mon-YYYY')															RES_INACTIVE_ON,
 RSC.LAST_UPDATED_BY 	RSC_LAST_UPDATED_BY
,RSC.LAST_UPDATE_DATE 	RSC_LAST_UPDATE_DATE
,RSC.CREATED_BY 		RSC_CREATED_BY
,RSC.CREATION_DATE 		RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,STAN.ORGANIZATION_ID  RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM  WIS_STANDARD_OPERATIONS_VL  STAN
	 , WIS_STD_OPERATION_RESOURCES  RSC
	 , WIS_RESOURCES_VL  AAA
WHERE STAN.STANDARD_OPERATION_ID =  RSC.STANDARD_OPERATION_ID 
and  RSC.RESOURCE_ID  = AAA.RESOURCE_ID
ORDER BY STAN.STANDARD_OPERATION_NAME  ,RSC.RESOURCE_SEQ_NUMBER    



