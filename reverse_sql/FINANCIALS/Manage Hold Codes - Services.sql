/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Hold Codes - Services.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HoldCodeEO.HOLD_CODE                                                     RES_CODE,
  HoldCodeEO.HOLD_NAME                                                          RES_NAME,
  TaskTypeEO.TASK_TYPE                                                          RES_TASK_TYPE,
  ServiceDefinitionEO.SERVICE_NAME                                              RES_SERVICE_NAME
,HoldServiceMappingEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,HoldServiceMappingEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,HoldServiceMappingEO.CREATED_BY RSC_CREATED_BY
,HoldServiceMappingEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_HOLD_SERVICE_MAPPINGS HoldServiceMappingEO,
  DOO_SERVICE_DEFINITIONS_VL ServiceDefinitionEO,
  DOO_TASK_TYPES_VL TaskTypeEO,
  DOO_HOLD_CODES_VL  HoldCodeEO
WHERE HoldServiceMappingEO.SERVICE_ID = ServiceDefinitionEO.SERVICE_ID
AND ServiceDefinitionEO.TASK_TYPE_ID  = TaskTypeEO.TASK_TYPE_ID
AND HoldCodeEO.HOLD_CODE_ID            = HoldServiceMappingEO.HOLD_CODE_ID
ORDER BY  HoldServiceMappingEO.HOLD_CODE_ID