/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Segment%20Value%20Security%20Rules%20-%20Conditions.sql $:
 * $Id: Manage Segment Value Security Rules - Conditions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT QRSLT.VALUE_SET_CODE RES_VALUE_SET_CODE
,QRSLT.INSTANCE_SET_NAME RES_NAME
,QRSLT.col RES_COLUMN_NAME
,QRSLT.TREE_OPERATORS RES_TREE_OPERATORS
,QRSLT.OPERATOR_ RES_OPERATOR
,QRSLT.VALUE_1 RES_VALUE_1
,QRSLT.VALUE_2 RES_VALUE_2
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ValueSetEO.VALUE_SET_ID
	,ValueSetEO.VALUE_SET_CODE
	,ValueSetEO.PROTECTED_FLAG
	,ValueSetEO.MODULE_ID
	,ValueSetEO.VALIDATION_TYPE
	,ValueSetEO.VALUE_DATA_TYPE
	,VALUESETEO.DESCRIPTION
	,VALUESETEO.SECURITY_ENABLED_FLAG
	,VALUESETEO.DATA_SECURITY_OBJECT_NAME
	,ApplTaxonomyPEO.MODULE_ID AS MODULE_ID1
	,ApplTaxonomyPEO.MODULE_TYPE
	,ApplTaxonomyPEO.MODULE_KEY
	,ApplTaxonomyPEO.USER_MODULE_NAME
	,ValidationTypeLookupPEO.LOOKUP_TYPE
	,ValidationTypeLookupPEO.LOOKUP_CODE
	,ValidationTypeLookupPEO.MEANING
	,ValueDataTypeLookupPEO.LOOKUP_TYPE
	,ValueDataTypeLookupPEO.LOOKUP_CODE
	,ValueDataTypeLookupPEO.MEANING
	,FndObjectInstanceSetsEO.INSTANCE_SET_NAME
	,FndObjectInstanceSetsEO.DISPLAY_NAME
	,FNDOBJECTINSTANCESETSEO.DESCRIPTION DESCRIPTION_1
	,EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/attributeName') col
	,(
		CASE
			WHEN EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/operator') != 'CUSTOM'
			THEN 'No'
			ELSE 'Yes'
		END) TREE_OPERATORS
	,(
		CASE
			WHEN EXTRACTVALUE(value(X),'/filterCriteriaItem/operator') != 'CUSTOM'
			THEN
				DECODE(EXTRACTVALUE(value(X),'/filterCriteriaItem/operator'),'EQUALTO','Equal to',(SELECT MEANING
				FROM GL_LOOKUPS
				WHERE LOOKUP_TYPE = 'FILTER_OPERATORS'
				AND LOOKUP_CODE   = EXTRACTVALUE(value(X),'/filterCriteriaItem/operator')
				))
			ELSE DECODE(EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[2]/value'),'IS_ANCESTOR_OF',
				'Is an ancestor of','IS_CHILD_OF','Is a child of','IS_FIRST_ANCESTOR_OF','Is a first ancestor of','IS_SIBLING_OF',
				'Is a sibling of','IS_PARENT_OF','Is a parent of','IS_LAST_DESCENDENT_OF','Is a last descendant of',
				'IS_DESCENDENT_OF','Is a descendant of')
		END) OPERATOR_
	,(
		CASE
			WHEN EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/operator') != 'CUSTOM'
			THEN EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/value[1]')
			ELSE EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[9]/value')
			     ||
				  EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[10]/value')
				  ||
				  EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[11]/value')
				  ||
				  EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[12]/value')
				  ||
				  EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[13]/value')
				  
		END) VALUE_1
	,EXTRACTVALUE(value(X),'/filterCriteriaItem/value[2]') VALUE_2
	,FndObjectInstanceSetsEO.predicate
	,FNDOBJECTINSTANCESETSEO.LAST_UPDATE_DATE
	,FNDOBJECTINSTANCESETSEO.LAST_UPDATED_BY
	,FNDOBJECTINSTANCESETSEO.CREATION_DATE
	,FNDOBJECTINSTANCESETSEO.CREATED_BY
	,FndObjectInstanceSetsEO.OBJECT_ID
	FROM FND_VS_VALUE_SETS ValueSetEO
	,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
	,FND_LOOKUPS ValidationTypeLookupPEO
	,FND_LOOKUPS ValueDataTypeLookupPEO
	,FND_OBJECTS_VL
	,FND_OBJECT_INSTANCE_SETS_VL FNDOBJECTINSTANCESETSEO
	,TABLE(XMLSEQUENCE(extract(FNDOBJECTINSTANCESETSEO.FILTER,
		'/FndFilter/GenericFilter/filterCriteriaRow/filterCriteriaItem'))) X
	WHERE ValueSetEO.MODULE_ID               = ApplTaxonomyPEO.MODULE_ID
	AND ValueSetEO.VALIDATION_TYPE           = ValidationTypeLookupPEO.LOOKUP_CODE
	AND VALUESETEO.VALUE_DATA_TYPE           = VALUEDATATYPELOOKUPPEO.LOOKUP_CODE
	AND FND_OBJECTS_VL.DATABASE_OBJECT_NAME  = 'FND_VS_VALUES_VL'
	AND VALUESETEO.DATA_SECURITY_OBJECT_NAME = FND_OBJECTS_VL.obj_name
	AND FndObjectInstanceSetsEO.OBJECT_ID    = FND_OBJECTS_VL.OBJECT_ID
	AND(ValueSetEO.module_id                IN
		(SELECT rf.child_module_id
		FROM fnd_appl_taxonomy_rf rf
		INNER JOIN fnd_appl_taxonomy t
		ON RF.ANCESTOR_MODULE_ID = T.MODULE_ID
		WHERE T.MODULE_TYPE      = 'APPLICATION'
		AND t.module_key         = 'GL'
		))
	AND(((VALUESETEO.VALUE_SET_CODE NOT LIKE('%$FLEX$%'))
	AND(VALIDATIONTYPELOOKUPPEO.LOOKUP_TYPE = 'FND_VS_VALIDATION_TYPES')
	AND(VALUEDATATYPELOOKUPPEO.LOOKUP_TYPE  = 'FND_VS_VALUE_DATA_TYPES')))
	) QRSLT
ORDER BY QRSLT.VALUE_SET_CODE
,QRSLT.INSTANCE_SET_NAME
,QRSLT.col