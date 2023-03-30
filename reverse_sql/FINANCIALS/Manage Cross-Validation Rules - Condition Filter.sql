/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Cross-Validation%20Rules%20-%20Condition%20Filter.sql $:
 * $Id: Manage Cross-Validation Rules - Condition Filter.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT STRUCTUREINSTANCE.NAME RES_CHART_OF_ACCOUNTS
,KFFCROSSVALRULEEO.RULE_CODE RES_NAME
,(SELECT COAMAPACCOUNTRULEEO.prompt
	FROM FND_KF_SEGMENTS_VL COAMAPACCOUNTRULEEO
	WHERE COAMAPACCOUNTRULEEO.COLUMN_NAME = EXTRACTVALUE(value(X),'/filterCriteriaItem/columnName')
	AND COAMAPACCOUNTRULEEO.STRUCTURE_ID = StructureInstance.STRUCTURE_ID
	) RES_ADD_FIELDS
,(CASE
	WHEN EXTRACTVALUE(value(X),'/filterCriteriaItem/operator') != 'CUSTOM' THEN
		(SELECT decode(MEANING,'Equals to','Equals','Not equals to','Does not equal','Greater than or equals to','Greater than or equal to',MEANING)
		FROM GL_LOOKUPS
		WHERE LOOKUP_TYPE = 'FILTER_OPERATORS'
		AND LOOKUP_CODE   = EXTRACTVALUE(value(X),'/filterCriteriaItem/operator'))
	ELSE
		EXTRACTVALUE(VALUE(X),'/filterCriteriaItem/properties/property[2]/value')
	END) RES_CONDITION
,TRIM(EXTRACTVALUE(value(X),'/filterCriteriaItem/value[1]')) RES_VALUE1
,TRIM(EXTRACTVALUE(value(X),'/filterCriteriaItem/value[2]')) RES_VALUE2
,KFFCrossValRuleEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,KFFCrossValRuleEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,KFFCrossValRuleEO.CREATED_BY RSC_CREATED_BY
,KFFCrossValRuleEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,StructureInstance.STRUCTURE_INSTANCE_NUMBER RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_CROSS_VAL_RULES KFFCrossValRuleEO
,FND_KF_STR_INSTANCES_VL STRUCTUREINSTANCE
,TABLE(XMLSEQUENCE(extract(KFFCrossValRuleEO.CONDITION_FILTER,
	'/FndFilter/KeyFlexFilter/filterCriteriaRow/filterCriteriaItem'))) X
WHERE KFFCrossValRuleEO.STRUCTURE_INSTANCE_ID              = StructureInstance.STRUCTURE_INSTANCE_ID
AND StructureInstance.APPLICATION_ID                       = 101
AND StructureInstance.KEY_FLEXFIELD_CODE                   = 'GL#'
AND EXTRACTVALUE(value(X),'/filterCriteriaItem/value[1]') IS NOT NULL
ORDER BY STRUCTUREINSTANCE.name
,KFFCROSSVALRULEEO.RULE_CODE
,EXTRACTVALUE(value(X),'/filterCriteriaItem/columnName')