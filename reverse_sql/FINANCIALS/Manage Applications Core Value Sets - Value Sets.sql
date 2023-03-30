/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Value%20Sets%20-%20Value%20Sets.sql $:
 * $Id: Manage Applications Core Value Sets - Value Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

 
 SELECT ValueSetEO.VALUE_SET_CODE                             RES_VALUE_SET_CODE,
  ValueSetEO.DESCRIPTION                                      RES_DESCRIPTION,
  (SELECT USER_MODULE_NAME
  FROM FND_APPL_TAXONOMY_VL
  WHERE MODULE_ID = ValueSetEO.MODULE_ID
  )                                                           RES_MODULE,
  ValidationTypeLookupPEO.MEANING                             RES_VALIDATION_TYPE,
  ValueDataTypeLookupPEO.MEANING                              RES_VALUE_DATA_TYPE,
  DECODE(ValueSetEO.VALIDATION_TYPE,'FORMAT',NULL,DECODE(ValueSetEO.SECURITY_ENABLED_FLAG,'Y','Yes','No')) RES_SECURITY_ENABLED,
  DECODE(ValueSetEO.VALIDATION_TYPE,'FORMAT',NULL,ValueSetEO.DATA_SECURITY_OBJECT_NAME) RES_DATA_SECURITY_RESOURCE_NAM,
  DECODE(ValueSetEO.VALIDATION_TYPE,'SUBSET',NULL,(select MEANING from  FND_LOOKUPS  
   where  LOOKUP_CODE = ValueSetEO.VALUE_SUBTYPE   
   AND LOOKUP_TYPE  = 'FND_VS_VARCHAR2_SUBTYPES' )) 			  RES_VALUE_SUBTYPE,
  DECODE(ValueSetEO.VALIDATION_TYPE,'TABLE',NULL,ValueSetEO.MAXIMUM_LENGTH)                                   RES_MAXIMUM_LENGTH,
  ValueSetEO.PRECISION                                        RES_PRECISION,
  ValueSetEO.SCALE                                            RES_SCALE,
(CASE
	WHEN ValueSetEO.VALUE_DATA_TYPE = 'DATE' THEN
		TO_CHAR(TO_DATE(ValueSetEO.MINIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY')
	WHEN ValueSetEO.VALUE_DATA_TYPE = 'TIMESTAMP' THEN
		TO_CHAR(TO_DATE(ValueSetEO.MINIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY HH24:MI:SS') 
	ELSE
		TO_CHAR(ValueSetEO.MINIMUM_VALUE)
	END) AS RES_MINIMUM_VALUE,
(CASE
	WHEN ValueSetEO.VALUE_DATA_TYPE = 'DATE' THEN
		TO_CHAR(TO_DATE(ValueSetEO.MAXIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY')
	WHEN ValueSetEO.VALUE_DATA_TYPE = 'TIMESTAMP' THEN
		TO_CHAR(TO_DATE(ValueSetEO.MAXIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY HH24:MI:SS') 
	ELSE
		TO_CHAR(ValueSetEO.MAXIMUM_VALUE)
	END) AS RES_MAXIMUM_VALUE,
  DECODE(ValueSetEO.VALUE_SUBTYPE, 'TEXT', DECODE(VALUESETEO.UPPERCASE_ONLY_FLAG,'Y','Yes','No')) RES_UPPERCASE_ONLY,
  DECODE(ValueSetEO.VALUE_SUBTYPE, 'TEXT', DECODE(VALUESETEO.ZERO_FILL_FLAG,'Y','Yes','No')) RES_ZERO_FILL    ,
  (SELECT VALUE_SET_CODE
  FROM FND_VS_VALUE_SETS
  WHERE VALUE_SET_ID= ValueSetEO.INDEPENDENT_VALUE_SET_ID
  )                                                           RES_INDEPENDENT_VALUE_SET_VALU,
  (SELECT DESCRIPTION
  FROM FND_VS_VALUE_SETS
  WHERE VALUE_SET_ID= ValueSetEO.INDEPENDENT_VALUE_SET_ID
  )                                                           RES_INDEPENDENT_VALUE_SET_DESC,
  TABLE_D.FROM_CLAUSE RES_FROM_CLAUSE,
  TABLE_D.VALUE_ATTRIBUTES_TBL_ALIAS   							RES_VALUE_ATTRIBUTES_TABLE_ALI,
  TABLE_D.VALUE_COLUMN_NAME 									RES_VALUE_COLUMN_NAME,
  TABLE_D.VALUE_COLUMN_TYPE 									RES_VALUE_COLUMN_TYPE,
  TABLE_D.VALUE_COLUMN_LENGTH 									RES_VALUE_COLUMN_LENGTH,
  TABLE_D.DESCRIPTION_COLUMN_NAME 								RES_DESCRIPTION_COLUMN_NAME,
  TABLE_D.DESCRIPTION_COLUMN_TYPE 								RES_DESCRIPTION_COLUMN_TYPE,
  TABLE_D.DESCRIPTION_COLUMN_LENGTH 							RES_DESCRIPTION_COLUMN_LENGTH,
  TABLE_D.ID_COLUMN_NAME 										RES_ID_COLUMN_NAME,
  TABLE_D.ID_COLUMN_TYPE 										RES_ID_COLUMN_TYPE,
  TABLE_D.ID_COLUMN_LENGTH 										RES_ID_COLUMN_LENGTH,
  TABLE_D.ENABLED_FLAG_COLUMN_NAME 								RES_ENABLED_FLAG_COLUMN_NAME,
  TABLE_D.START_DATE_COLUMN_NAME 								RES_START_DATE_COLUMN_NAME,
  TABLE_D.END_DATE_COLUMN_NAME 									RES_END_DATE_COLUMN_NAME,
  TABLE_D.WHERE_CLAUSE 											RES_WHERE_CLAUSE,
  TABLE_D.ORDER_BY_CLAUSE 										RES_ORDER_BY_CLAUSE
  ,ValueSetEO.LAST_UPDATED_BY   								RSC_LAST_UPDATED_BY
  ,ValueSetEO.LAST_UPDATE_DATE   								RSC_LAST_UPDATE_DATE
  ,ValueSetEO.CREATED_BY  										RSC_CREATED_BY
  ,ValueSetEO.CREATION_DATE  									RSC_CREATION_DATE
  ,null 														RSC_LEDGER_ID
  ,null 														RSC_CHART_OF_ACCOUNTS_ID
  ,null 														RSC_BUSINESS_UNIT_ID
  ,null 														RSC_LEGAL_ENTITY_ID
  ,null 														RSC_ORGANIZATION_ID
  ,null 														RSC_BUSINESS_GROUP_ID
  ,ValueSetEO.ENTERPRISE_ID 									RSC_ENTERPRISE_ID
  ,null 														RSC_COUNTRY_ID  
   
FROM FND_VS_VALUE_SETS ValueSetEO,
  FND_APPL_TAXONOMY_VL ApplTaxonomyPEO,
  FND_LOOKUPS ValidationTypeLookupPEO,
  FND_LOOKUPS ValueDataTypeLookupPEO,
  FND_VS_VT_TABLE_EXT   TABLE_D
WHERE ValueSetEO.MODULE_ID     = ApplTaxonomyPEO.MODULE_ID
AND ValueSetEO.VALIDATION_TYPE = ValidationTypeLookupPEO.LOOKUP_CODE
AND ValueSetEO.VALUE_DATA_TYPE = ValueDataTypeLookupPEO.LOOKUP_CODE
AND ValueSetEO.VALUE_SET_ID = TABLE_D.VALUE_SET_ID(+)
AND (ValueSetEO.module_id     IN
  (SELECT rf.child_module_id
  FROM fnd_appl_taxonomy_rf rf
  INNER JOIN fnd_appl_taxonomy t
  ON rf.ancestor_module_id = t.module_id
  WHERE t.module_type      = 'APPLICATION'
  AND t.module_key         = 'FND'))
AND ( ( (ValueSetEO.VALUE_SET_CODE NOT LIKE ('%'  || '$FLEX$'  || '%') )
AND (ValidationTypeLookupPEO.LOOKUP_TYPE = 'FND_VS_VALIDATION_TYPES' )
AND (ValueDataTypeLookupPEO.LOOKUP_TYPE  = 'FND_VS_VALUE_DATA_TYPES' ) ) )

ORDER BY ValueSetEO.VALUE_SET_CODE