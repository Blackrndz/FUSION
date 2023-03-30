/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT Head.VALUE_SET_CODE  RES_VALUE_SET_CODE
,decode(Head.VALUE_DATA_MEANING,'Date',to_char(to_date(Detail.VALUE,'YYYY/MM/DD hh24:mi:ss'),'DD-Mon-YYYY'),'Date Time',to_char(to_date(Detail.VALUE,'YYYY/MM/DD hh24:mi:ss'),'DD-Mon-YYYY hh24:mi:ss'),Detail.VALUE)     RES_VALUE
,decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.TRANSLATED_VALUE,Detail.TRANSLATED_VALUE) RES_TRANSLATED_VALUE
,decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.DESCRIPTION,Detail.DESCRIPTION)         RES_DESCRIPTION
,decode(decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.ENABLED_FLAG,Detail.ENABLED_FLAG),'Y','Yes','No')         RES_ENABLED
,to_char(decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.START_DATE_ACTIVE,Detail.START_DATE_ACTIVE),'DD-Mon-YYYY')   RES_START_DATE
,to_char(decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.END_DATE_ACTIVE,Detail.END_DATE_ACTIVE),'DD-Mon-YYYY')     RES_END_DATE
--,decode(Head.VALUE_DATA_MEANING,'Date',to_char(to_date(Detail.independent_value,'YYYY/MM/DD hh24:mi:ss'),'DD-Mon-YYYY '),'Date Time',to_char(to_date(Detail.independent_value,'YYYY/MM/DD hh24:mi:ss'),'DD-Mon-YYYY hh24:mi:ss'),Detail.independent_value)     RES_INDEPENDENT_VALUE
,decode(HEAD.independent_value_set_id,null,null,decode( ( select distinct BBB.meaning from FUSION.FND_VS_VALUE_SETS AAA , FUSION.FND_LOOKUPS BBB
                                                               where AAA.value_set_id = HEAD.independent_value_set_id
                                                               and   AAA.VALUE_DATA_TYPE = BBB.LOOKUP_CODE
                                                               AND BBB.LOOKUP_TYPE = 'FND_VS_VALUE_DATA_TYPES')
                                                              ,'Date',to_char(to_date(decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.independent_value,Detail.independent_value),'YYYY/MM/DD hh24:mi:ss'),'MM/DD/YYYY ')
                                                              ,'Date Time',to_char(to_date(decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.independent_value,Detail.independent_value),'YYYY/MM/DD hh24:mi:ss'),'DD-Mon-YYYY hh24:mi:ss')
                                                              ,decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.independent_value,Detail.independent_value))  
                                                               
              ) RES_INDEPENDENT_VALUE
,decode(Head.VALIDATION_MEANING,'Subset',SubsetValue.SORT_ORDER,Detail.SORT_ORDER)          RES_SORT_ORDER
,decode(decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.SUMMARY_FLAG, Detail.SUMMARY_FLAG),'Y','Yes','N','No')            RES_SUMMARY
,decode(decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.FLEX_VALUE_ATTRIBUTE1, Detail.FLEX_VALUE_ATTRIBUTE1),'Y','Yes','N','No')   RES_ALLOW_POSTING
,decode(decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.FLEX_VALUE_ATTRIBUTE2, Detail.FLEX_VALUE_ATTRIBUTE2),'Y','Yes','N','No')   RES_ALLOW_BUDGETING
,(CASE
	WHEN EXISTS (SELECT 1
		FROM FND_KF_SEGMENT_INSTANCES segKfInst
		,FND_KF_STR_INSTANCES_VL kfInst
		,FND_KF_LABELED_SEGMENTS kfLabels
		WHERE kfInst.STRUCTURE_INSTANCE_ID = kfInst.STRUCTURE_INSTANCE_ID
		AND kfInst.STRUCTURE_ID = kfLabels.STRUCTURE_ID
		AND segKfInst.SEGMENT_CODE = kfLabels.SEGMENT_CODE
		AND kfLabels.SEGMENT_LABEL_CODE = 'GL_ACCOUNT'
		AND segKfInst.VALUE_SET_ID = Head.VALUE_SET_ID) THEN
			(select LookupPEO.MEANING  
				FROM FUSION.FND_LOOKUPS LookupPEO  
				where lookuppeo.lookup_code = decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.FLEX_VALUE_ATTRIBUTE3, Detail.FLEX_VALUE_ATTRIBUTE3)
				and LookupPEO.lookup_type = 'ACCOUNT_TYPE' 
				and LookupPEO.ENABLED_FLAG = 'Y' )
	END) RES_ACCOUNT_TYPE
,(CASE
	WHEN EXISTS (SELECT 1
		FROM FND_KF_SEGMENT_INSTANCES segKfInst
		,FND_KF_STR_INSTANCES_VL kfInst
		,FND_KF_LABELED_SEGMENTS kfLabels
		WHERE kfInst.STRUCTURE_INSTANCE_ID = kfInst.STRUCTURE_INSTANCE_ID
		AND kfInst.STRUCTURE_ID = kfLabels.STRUCTURE_ID
		AND segKfInst.SEGMENT_CODE = kfLabels.SEGMENT_CODE
		AND kfLabels.SEGMENT_LABEL_CODE = 'GL_ACCOUNT'
		AND segKfInst.VALUE_SET_ID = Head.VALUE_SET_ID) THEN
			(select LookupPEO.MEANING  
				FROM FUSION.FND_LOOKUPS LookupPEO  
				where lookuppeo.lookup_code = decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.FLEX_VALUE_ATTRIBUTE4, Detail.FLEX_VALUE_ATTRIBUTE4)
				and LookupPEO.lookup_type = 'GL_CONTROL_ACCOUNT_SOURCES' 
				and LookupPEO.ENABLED_FLAG = 'Y' )
	END) RES_THIRD_PARTY_CONTROL_ACCOUN
,(CASE
	WHEN EXISTS (SELECT 1
		FROM FND_KF_SEGMENT_INSTANCES segKfInst
		,FND_KF_STR_INSTANCES_VL kfInst
		,FND_KF_LABELED_SEGMENTS kfLabels
		WHERE kfInst.STRUCTURE_INSTANCE_ID = kfInst.STRUCTURE_INSTANCE_ID
		AND kfInst.STRUCTURE_ID = kfLabels.STRUCTURE_ID
		AND segKfInst.SEGMENT_CODE = kfLabels.SEGMENT_CODE
		AND kfLabels.SEGMENT_LABEL_CODE = 'GL_ACCOUNT'
		AND segKfInst.VALUE_SET_ID = Head.VALUE_SET_ID) THEN
			decode(decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.FLEX_VALUE_ATTRIBUTE5, Detail.FLEX_VALUE_ATTRIBUTE5),'Y','Yes','N','No')   
	END) RES_RECONCILE
,(CASE
	WHEN EXISTS (SELECT 1
		FROM FND_KF_SEGMENT_INSTANCES segKfInst
		,FND_KF_STR_INSTANCES_VL kfInst
		,FND_KF_LABELED_SEGMENTS kfLabels
		WHERE kfInst.STRUCTURE_INSTANCE_ID = kfInst.STRUCTURE_INSTANCE_ID
		AND kfInst.STRUCTURE_ID = kfLabels.STRUCTURE_ID
		AND segKfInst.SEGMENT_CODE = kfLabels.SEGMENT_CODE
		AND kfLabels.SEGMENT_LABEL_CODE = 'GL_ACCOUNT'
		AND segKfInst.VALUE_SET_ID = Head.VALUE_SET_ID) THEN
			(select LookupPEO.MEANING  
				FROM FUSION.FND_LOOKUPS LookupPEO  
				where lookuppeo.lookup_code = decode(Head.VALIDATION_MEANING,'Subset', SubsetValue.FLEX_VALUE_ATTRIBUTE6, Detail.FLEX_VALUE_ATTRIBUTE6)
				and LookupPEO.lookup_type = 'FINANCIAL_CATEGORY' 
				and LookupPEO.ENABLED_FLAG = 'Y')
	END) RES_FINANCIAL_CATEGORY
,Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,Head.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM
(
   SELECT ValueSetEO.VALUE_SET_ID, 
       ValueSetEO.VALUE_SET_CODE,         
       ValueSetEO.PROTECTED_FLAG,  
       ValueSetEO.DESCRIPTION, 
       ApplTaxonomyPEO.USER_MODULE_NAME, 
       ValidationTypeLookupPEO.MEANING  VALIDATION_MEANING, 
       VALUEDATATYPELOOKUPPEO.MEANING VALUE_DATA_MEANING,   
       ValueSetEO.independent_value_set_id,
       ValueSetEO.LAST_UPDATED_BY,
       ValueSetEO.LAST_UPDATE_DATE,
       ValueSetEO.CREATED_BY,
       ValueSetEO.CREATION_DATE   
       ,ValueSetEO.ENTERPRISE_ID	   
    FROM FUSION.FND_VS_VALUE_SETS ValueSetEO, 
         FUSION.FND_APPL_TAXONOMY_VL ApplTaxonomyPEO, 
         FUSION.FND_LOOKUPS ValidationTypeLookupPEO, 
         FUSION.FND_LOOKUPS ValueDataTypeLookupPEO 
    WHERE ValueSetEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID 
    AND ValueSetEO.VALIDATION_TYPE = ValidationTypeLookupPEO.LOOKUP_CODE 
    AND ValueSetEO.VALUE_DATA_TYPE = ValueDataTypeLookupPEO.LOOKUP_CODE 
    AND (ValueSetEO.module_id in (select rf.child_module_id
                                  from FUSION.fnd_appl_taxonomy_rf rf
                                  inner join FUSION.fnd_appl_taxonomy t
                                  on rf.ancestor_module_id = t.module_id
                                  where t.module_type = 'APPLICATION' and t.module_key = 'GL'
                                  ))
    AND ValidationTypeLookupPEO.LOOKUP_TYPE = 'FND_VS_VALIDATION_TYPES' 
    AND ValueDataTypeLookupPEO.LOOKUP_TYPE = 'FND_VS_VALUE_DATA_TYPES'  
        
) Head,
(
  SELECT  
   VALUE_SET_ID
  ,TRANSLATED_VALUE
  ,ATTRIBUTE_CATEGORY 
  ,VALUE  
  ,DESCRIPTION 
  ,ENABLED_FLAG 
  ,START_DATE_ACTIVE 
  ,END_DATE_ACTIVE 
  ,SORT_ORDER  
  ,SUMMARY_FLAG 
  ,FLEX_VALUE_ATTRIBUTE1  
  ,FLEX_VALUE_ATTRIBUTE2  
  ,independent_value
  ,LAST_UPDATED_BY 
  ,LAST_UPDATE_DATE 
  ,CREATED_BY 
  ,CREATION_DATE 
  ,FLEX_VALUE_ATTRIBUTE3  
  ,FLEX_VALUE_ATTRIBUTE4  
  ,FLEX_VALUE_ATTRIBUTE5  
  ,FLEX_VALUE_ATTRIBUTE6
  FROM FUSION.FND_VS_VALUES_VL 
) Detail
,(SELECT ValueSetValueEO.VALUE_ID
,ValueSetValueEO.VALUE_SET_ID
,ValueSetValueEO.INDEPENDENT_VALUE
,ValueSetValueEO.INDEPENDENT_VALUE_NUMBER
,ValueSetValueEO.INDEPENDENT_VALUE_DATE
,ValueSetValueEO.INDEPENDENT_VALUE_TIMESTAMP
,ValueSetValueEO.VALUE
,ValueSetValueEO.VALUE_NUMBER
,ValueSetValueEO.VALUE_DATE
,ValueSetValueEO.VALUE_TIMESTAMP
,IndepValueSetValueEO.VALUE_ID AS VALUE_ID1
,IndepValueSetValueEO.VALUE_SET_ID AS VALUE_SET_ID1
,IndepValueSetValueEO.DESCRIPTION
,IndepValueSetValueEO.TRANSLATED_VALUE
,IndepValueSetValueEO.ENABLED_FLAG
,IndepValueSetValueEO.START_DATE_ACTIVE
,IndepValueSetValueEO.END_DATE_ACTIVE
,IndepValueSetValueEO.SORT_ORDER
,ValueSetValueEO.CREATED_BY
,IndepValueSetValueEO.SUMMARY_FLAG 
,IndepValueSetValueEO.FLEX_VALUE_ATTRIBUTE1  
,IndepValueSetValueEO.FLEX_VALUE_ATTRIBUTE2 
,IndepValueSetValueEO.FLEX_VALUE_ATTRIBUTE3  
,IndepValueSetValueEO.FLEX_VALUE_ATTRIBUTE4 
,IndepValueSetValueEO.FLEX_VALUE_ATTRIBUTE5  
,IndepValueSetValueEO.FLEX_VALUE_ATTRIBUTE6
FROM FND_VS_VALUES_VL ValueSetValueEO
,FND_VS_VALUE_SETS ValueSetEO
,FND_VS_VALUES_VL IndepValueSetValueEO
WHERE ValueSetValueEO.VALUE_SET_ID      = ValueSetEO.VALUE_SET_ID
AND ValueSetEO.INDEPENDENT_VALUE_SET_ID = IndepValueSetValueEO.VALUE_SET_ID
AND ValueSetValueEO.VALUE               = IndepValueSetValueEO.VALUE) SubsetValue
WHERE Head.VALUE_SET_ID = Detail.VALUE_SET_ID
And detail.VALUE_SET_ID = SubsetValue.VALUE_SET_ID(+)
And detail.VALUE = SubsetValue.VALUE(+)
ORDER BY Head.VALUE_SET_CODE
,RES_VALUE