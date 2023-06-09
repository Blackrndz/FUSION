/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Sets%20-%20Manage%20Value%20Set.sql $:
 * $Id: Manage Chart of Accounts Value Sets - Manage Value Set.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select  QRSLT.VALUE_SET_CODE RES_VALUE_SET_CODE,
          QRSLT.DESCRIPTION RES_DESCRIPTION,
          QRSLT.USER_MODULE_NAME RES_MODULE,
          QRSLT.VALIDATION_MEANING RES_VALIDATION_TYPE,
          QRSLT.VALUE_DATA_MEANING RES_VALUE_DATA_TYPE,
          DECODE(QRSLT.VALIDATION_MEANING,'Format Only',NULL,DECODE(QRSLT.SECURITY_ENABLED_FLAG,'Y','Yes','No')) RES_SECURITY_ENABLED,
         DECODE(QRSLT.VALIDATION_MEANING,'Format Only',NULL,QRSLT.DATA_SECURITY_OBJECT_NAME) RES_DATA_SECURITY_RESOURCE_NAM,
         DECODE(QRSLT.VALIDATION_MEANING,'Subset',NULL,(select MEANING from  FUSION.FND_LOOKUPS   where    LOOKUP_CODE= QRSLT.VALUE_SUBTYPE   AND LOOKUP_TYPE  = 'FND_VS_VARCHAR2_SUBTYPES') ) RES_VALUE_SUBTYPE,
         DECODE(QRSLT.VALIDATION_MEANING,'Table',NULL,QRSLT.MAXIMUM_LENGTH) RES_MAXIMUM_LENGTH,      
         QRSLT.precision RES_PRECISION,
        QRSLT.scale RES_SCALE
,(CASE
	WHEN QRSLT.VALUE_DATA_TYPE1 = 'DATE' THEN
		TO_CHAR(TO_DATE(QRSLT.MINIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY')
	WHEN QRSLT.VALUE_DATA_TYPE1 = 'TIMESTAMP' THEN
		TO_CHAR(TO_DATE(QRSLT.MINIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY HH24:MI:SS') 
	ELSE
		TO_CHAR(QRSLT.MINIMUM_VALUE)
	END) AS RES_MINIMUM_VALUE
,(CASE
	WHEN QRSLT.VALUE_DATA_TYPE1 = 'DATE' THEN
		TO_CHAR(TO_DATE(QRSLT.MAXIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY')
	WHEN QRSLT.VALUE_DATA_TYPE1 = 'TIMESTAMP' THEN
		TO_CHAR(TO_DATE(QRSLT.MAXIMUM_VALUE,'YYYY/MM/DD HH24:MI:SS'),'DD-Mon-YYYY HH24:MI:SS') 
	ELSE
		TO_CHAR(QRSLT.MAXIMUM_VALUE)
	END) AS RES_MAXIMUM_VALUE,
        DECODE(QRSLT.VALIDATION_MEANING,'Subset',NULL,(DECODE(QRSLT.VALUE_SUBTYPE, 'TEXT', DECODE(QRSLT.UPPERCASE_ONLY_FLAG,'Y','Yes','N','No')))) RES_UPPERCASE_ONLY,
        DECODE(QRSLT.VALIDATION_MEANING,'Subset',NULL,(DECODE(QRSLT.VALUE_SUBTYPE, 'TEXT', DECODE(QRSLT.ZERO_FILL_FLAG,'Y','Yes','N','No')))) RES_ZERO_FILL ,
        QRSLT.IN_VALUE_SET_CODE RES_INDEPENDENT_VALUE_SET_VALU,
        QRSLT.IN_DESCRIPTION RES_INDEPENDENT_VALUE_SET_DESC,
        TABLE_EXT.FROM_CLAUSE RES_FROM_CLAUSE,         
            TABLE_EXT.VALUE_ATTRIBUTES_TBL_ALIAS RES_VALUE_ATTRIBUTES_TABLE_ALI,
            TABLE_EXT.VALUE_COLUMN_NAME RES_VALUE_COLUMN_NAME,
            TABLE_EXT.VALUE_COLUMN_TYPE RES_VALUE_COLUMN_TYPE,
            TABLE_EXT.VALUE_COLUMN_LENGTH RES_VALUE_COLUMN_LENGTH,
            TABLE_EXT.DESCRIPTION_COLUMN_NAME RES_DESCRIPTION_COLUMN_NAME,
            TABLE_EXT.DESCRIPTION_COLUMN_TYPE RES_DESCRIPTION_COLUMN_TYPE,
            TABLE_EXT.DESCRIPTION_COLUMN_LENGTH RES_DESCRIPTION_COLUMN_LENGTH,
            TABLE_EXT.ID_COLUMN_NAME RES_ID_COLUMN_NAME,
            TABLE_EXT.ID_COLUMN_TYPE RES_ID_COLUMN_TYPE,
            TABLE_EXT.ID_COLUMN_LENGTH RES_ID_COLUMN_LENGTH,
            TABLE_EXT.ENABLED_FLAG_COLUMN_NAME RES_ENABLED_FLAG_COLUMN_NAME,
            TABLE_EXT.START_DATE_COLUMN_NAME RES_START_DATE_COLUMN_NAME,
            TABLE_EXT.END_DATE_COLUMN_NAME RES_END_DATE_COLUMN_NAME,
            TABLE_EXT.WHERE_CLAUSE RES_WHERE_CLAUSE,
            TABLE_EXT.ORDER_BY_CLAUSE RES_ORDER_BY_CLAUSE 
			,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
			,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
			,QRSLT.CREATED_BY  RSC_CREATED_BY
			,QRSLT.CREATION_DATE  RSC_CREATION_DATE
			, null RSC_LEDGER_ID
			, null RSC_CHART_OF_ACCOUNTS_ID
			, null RSC_BUSINESS_UNIT_ID
			, null RSC_LEGAL_ENTITY_ID
			, null RSC_ORGANIZATION_ID
			, null RSC_BUSINESS_GROUP_ID
			, QRSLT.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

            
from
  ( 
  select VALUESETEO.VALUE_SET_ID,
  VALUESETEO.LAST_UPDATED_BY ,
  ValueSetEO.last_update_date ,
    ValueSetEO.VALUE_SET_CODE,
    ValueSetEO.PROTECTED_FLAG,
    ValueSetEO.CREATED_BY,
  ValueSetEO.CREATION_DATE ,
    ValueSetEO.ENTERPRISE_ID ,
    ValueSetEO.MODULE_ID,
    ValueSetEO.VALIDATION_TYPE,
    ValueSetEO.VALUE_DATA_TYPE VALUE_DATA_TYPE1,
    ValueSetEO.DESCRIPTION,
    ApplTaxonomyPEO.MODULE_ID AS MODULE_ID1,
    ApplTaxonomyPEO.MODULE_TYPE,
    ApplTaxonomyPEO.MODULE_KEY,
    APPLTAXONOMYPEO.USER_MODULE_NAME,
    VALIDATIONTYPELOOKUPPEO.LOOKUP_TYPE VALIDATION_TYPE,
    VALIDATIONTYPELOOKUPPEO.LOOKUP_CODE VALIDATION_CODE,
    VALIDATIONTYPELOOKUPPEO.MEANING VALIDATION_meaning,
    VALUEDATATYPELOOKUPPEO.LOOKUP_TYPE Value_data_Type,
    VALUEDATATYPELOOKUPPEO.LOOKUP_CODE VALUE_DATA_CODE,
    VALUEDATATYPELOOKUPPEO.MEANING VALUE_DATA_MEANING,    
    VALUESETEO.VALIDATION_TYPE ,
    VALIDATIONTYPELOOKUPPEO.LOOKUP_TYPE ,  
    ValueSetEO.SECURITY_ENABLED_FLAG,
  ValueSetEO.DATA_SECURITY_OBJECT_NAME,
  ValueSetEO.VALUE_DATA_TYPE,
  ValueSetEO.VALUE_SUBTYPE,
  ValueSetEO.PROTECTED_FLAG,
  ValueSetEO.MAXIMUM_LENGTH,
  ValueSetEO.PRECISION,
  ValueSetEO.SCALE,
  ValueSetEO.MINIMUM_VALUE,
  ValueSetEO.MAXIMUM_VALUE,
  VALUESETEO.UPPERCASE_ONLY_FLAG,
  VALUESETEO.ZERO_FILL_FLAG,
   IndependentValueSetEO.VALUE_SET_ID   IN_VALUE_SET_ID,
  INDEPENDENTVALUESETEO.VALUE_SET_CODE  IN_VALUE_SET_CODE,
  IndependentValueSetEO.DESCRIPTION     IN_DESCRIPTION  
  FROM FUSION.FND_VS_VALUE_SETS ValueSetEO,
    FUSION.FND_APPL_TAXONOMY_VL APPLTAXONOMYPEO,
    FUSION.FND_LOOKUPS VALIDATIONTYPELOOKUPPEO,
    FUSION.FND_LOOKUPS VALUEDATATYPELOOKUPPEO   ,
    FUSION.FND_VS_VALUE_SETS INDEPENDENTVALUESETEO      
  WHERE ValueSetEO.MODULE_ID     = ApplTaxonomyPEO.MODULE_ID
  AND ValueSetEO.VALIDATION_TYPE = ValidationTypeLookupPEO.LOOKUP_CODE
  and VALUESETEO.VALUE_DATA_TYPE = VALUEDATATYPELOOKUPPEO.LOOKUP_CODE
  and VALUESETEO.INDEPENDENT_VALUE_SET_ID = INDEPENDENTVALUESETEO.VALUE_SET_ID(+)   
   AND VALUEDATATYPELOOKUPPEO.LOOKUP_TYPE  = 'FND_VS_VALUE_DATA_TYPES'
  and VALIDATIONTYPELOOKUPPEO.LOOKUP_TYPE  = 'FND_VS_VALIDATION_TYPES'  
  AND (ValueSetEO.module_id     IN
    (select RF.CHILD_MODULE_ID
    from FUSION.FND_APPL_TAXONOMY_RF RF,
    FUSION.FND_APPL_TAXONOMY T
    where RF.ANCESTOR_MODULE_ID = T.MODULE_ID
    and T.MODULE_TYPE      = 'APPLICATION' 
    and T.MODULE_KEY         = 'GL'
    ))  
   ) QRSLT ,
  (SELECT ValueSetValidationTableEO.VALUE_SET_ID,
            ValueSetValidationTableEO.FROM_CLAUSE,
            ValueSetValidationTableEO.VALUE_ATTRIBUTES_TBL_ALIAS,
            ValueSetValidationTableEO.VALUE_COLUMN_NAME,
            ValueSetValidationTableEO.VALUE_COLUMN_TYPE,
            ValueSetValidationTableEO.VALUE_COLUMN_LENGTH,
            ValueSetValidationTableEO.DESCRIPTION_COLUMN_NAME,
            ValueSetValidationTableEO.DESCRIPTION_COLUMN_TYPE,
            ValueSetValidationTableEO.DESCRIPTION_COLUMN_LENGTH,
            ValueSetValidationTableEO.ID_COLUMN_NAME,
            ValueSetValidationTableEO.ID_COLUMN_TYPE,
            ValueSetValidationTableEO.ID_COLUMN_LENGTH,
            ValueSetValidationTableEO.ENABLED_FLAG_COLUMN_NAME,
            ValueSetValidationTableEO.START_DATE_COLUMN_NAME,
            ValueSetValidationTableEO.END_DATE_COLUMN_NAME,
            ValueSetValidationTableEO.WHERE_CLAUSE,
            VALUESETVALIDATIONTABLEEO.ORDER_BY_CLAUSE
from FUSION.FND_VS_VT_TABLE_EXT VALUESETVALIDATIONTABLEEO) TABLE_EXT
where   QRSLT.VALUE_SET_ID = TABLE_EXT.VALUE_SET_ID(+)
order by decode(nvl(RES_INDEPENDENT_VALUE_SET_VALU,'2'),'2','1','9') ,QRSLT.VALUE_SET_CODE ,QRSLT.Validation_meaning ,QRSLT.user_module_name