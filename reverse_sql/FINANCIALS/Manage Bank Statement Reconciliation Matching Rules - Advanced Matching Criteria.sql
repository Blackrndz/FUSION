/* ****************************************************************************
* $Revision: 58428 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Bank%20Statement%20Reconciliation%20Matching%20Rules%20-%20Advanced%20Matching%20Criteria.sql $:
* $Id: Manage Bank Statement Reconciliation Matching Rules - Advanced Matching Criteria.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT bbb.MATCHING_RULE_NAME RES_NAME
,RES_PARENT_GROUP 
,RES_GROUP
,RES_CONDITION_CONJUNCTION_OPER
,RES_CASE_SENSITIVE_COMPARISON
,RES_LEFT_HAND_SIDE_EXPRESSION_
,RES_LEFT_HAND_SIDE_EXPRESSIO_0
,RES_LEFT_HAND_SIDE_EXPRESSIO_1
,RES_LEFT_HAND_SIDE_EXPRESSIO_2
,RES_OPERATOR
,RES_RIGHT_HAND_SIDE_EXPRESSION
,RES_RIGHT_HAND_SIDE_EXPRESSI_3
,RES_RIGHT_HAND_SIDE_EXPRESSI_4
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
(SELECT CRITERIA_ID
,PARENT_ID
,(CASE
	WHEN PARENT_TYPE = 'GROUP' THEN
		(SELECT TRIM(CONJUNCTION_OPERATOR||' Group')
			FROM ATK_QB_QRY_CRITERIA
			WHERE CRITERIA_ID = AQQC.PARENT_ID
		)
	END) RES_PARENT_GROUP
,(CASE
	WHEN CRITERIA_TYPE = 'GROUP' THEN
		NVL((SELECT MEANING
			FROM ATK_LOOKUPS
			WHERE LOOKUP_TYPE = 'ATK_QB_CONJUNCTION_OPER_TYPE'
			AND LOOKUP_CODE = AQQC.CONJUNCTION_OPERATOR),'Group')
	END) RES_GROUP
,(CASE
	WHEN CRITERIA_TYPE = 'ITEM' THEN
		(SELECT MEANING
			FROM ATK_LOOKUPS
			WHERE LOOKUP_TYPE = 'ATK_QB_CONJUNCTION_OPER_TYPE'
			AND LOOKUP_CODE = AQQC.CONJUNCTION_OPERATOR)
	END) RES_CONDITION_CONJUNCTION_OPER
,(CASE 
	WHEN AQQC.LHSLEFT_OPERAND_TYPE = 'STRING' THEN
		DECODE(AQQC.CASE_SENSITIVE_FLAG,'Y','Yes','No')
	END) RES_CASE_SENSITIVE_COMPARISON
,(SELECT MEANING
	FROM ATK_LOOKUPS
	WHERE LOOKUP_TYPE = 'ATK_QB_LEFTHAND_OPERAND_TYPE'
	AND LOOKUP_CODE = AQQC.LEFT_HAND_EXP_TYPE
	) RES_LEFT_HAND_SIDE_EXPRESSION_
,(SELECT MEANING
	FROM ATK_LOOKUPS
	WHERE LOOKUP_TYPE = 'ATK_QB_CRITERIA_OPERATION_TYPE'
	AND LOOKUP_CODE = AQQC.OPERATION_NAME
	) RES_LEFT_HAND_SIDE_EXPRESSIO_0
,(SELECT ATTRIBUTE_REF_USER_NAME
	FROM ATK_QB_ENT_ATTR_REFS_VL
	WHERE ATTRIBUTE_REFERENCE_ID = (SELECT REFERENCE_ATTRIBUTE_ID
		FROM ATK_QB_QRY_GRP_ATTRIBUTES
		WHERE ATTRIBUTE_ID = AQQC.LHSLEFT_OPERAND_IDENTIFIER)
	) RES_LEFT_HAND_SIDE_EXPRESSIO_1
,(SELECT ATTRIBUTE_REF_USER_NAME
	FROM ATK_QB_ENT_ATTR_REFS_VL
	WHERE ATTRIBUTE_REFERENCE_ID = (SELECT REFERENCE_ATTRIBUTE_ID
		FROM ATK_QB_QRY_GRP_ATTRIBUTES
		WHERE ATTRIBUTE_ID = AQQC.LHSRGHT_OPERAND_IDENTIFIER)
	) RES_LEFT_HAND_SIDE_EXPRESSIO_2
,(SELECT MEANING
	FROM ATK_LOOKUPS
	WHERE LOOKUP_TYPE = 'ATK_QB_'||AQQC.LHSLEFT_OPERAND_TYPE||'_OPERATOR_TYPE'
	AND LOOKUP_CODE = AQQC.OPERATOR_CODE
	) RES_OPERATOR
,(SELECT MEANING
	FROM ATK_LOOKUPS
	WHERE LOOKUP_TYPE = 'ATK_QB_RIGHTHAND_OPERAND_TYPE'
	AND LOOKUP_CODE = AQQC.RHS_OPERAND_TYPE
	) RES_RIGHT_HAND_SIDE_EXPRESSION
,(CASE
	WHEN LHSLEFT_OPERAND_TYPE = 'STRING' THEN
		AQQC.RHS_LITERAL_VALUE 
	WHEN LHSLEFT_OPERAND_TYPE = 'DATE' THEN
		TO_CHAR(AQQC.RHS_DATE_LITERAL_VALUE,'DD-Mon-YYYY')
	ELSE
		TO_CHAR(AQQC.RHS_NUMBER_LITERAL_VALUE)
	END) RES_RIGHT_HAND_SIDE_EXPRESSI_3
,(CASE
	WHEN AQQC.RHS_OPERAND_TYPE = 'ATTRIBUTE' THEN
		(SELECT ATTRIBUTE_REF_USER_NAME
			FROM ATK_QB_ENT_ATTR_REFS_VL
			WHERE ATTRIBUTE_REFERENCE_ID = (SELECT REFERENCE_ATTRIBUTE_ID
				FROM ATK_QB_QRY_GRP_ATTRIBUTES
				WHERE ATTRIBUTE_ID = AQQC.RHS_OPERAND_IDENTIFIER)
			)
	END) RES_RIGHT_HAND_SIDE_EXPRESSI_4
,CONNECT_BY_ROOT AQQC.PARENT_ID ROOT_ID
,AQQC.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AQQC.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AQQC.CREATED_BY RSC_CREATED_BY
,AQQC.CREATION_DATE RSC_CREATION_DATE
FROM ATK_QB_QRY_CRITERIA AQQC
START WITH AQQC.PARENT_ID NOT IN (SELECT CRITERIA_ID FROM ATK_QB_QRY_CRITERIA)
CONNECT BY PRIOR AQQC.CRITERIA_ID = AQQC.PARENT_ID) AQQC
,ATK_QB_QUERIES_B XX 
,(SELECT MATCHING_RULE_NAME
	,RECON_MATCHING_RULE_ID
	FROM CE_RECON_MATCHING_RULES
	WHERE length(nvl(JOIN_CONDITION,'X')) NOT IN (0,1)
	) bbb
WHERE XX.QUERY_ID = AQQC.ROOT_ID
and SUBSTR(XX.QUERY_NAME, - 15) = TO_CHAR(bbb.RECON_MATCHING_RULE_ID)
START WITH AQQC.PARENT_ID NOT IN (SELECT CRITERIA_ID FROM ATK_QB_QRY_CRITERIA)
CONNECT BY PRIOR AQQC.CRITERIA_ID = AQQC.PARENT_ID
ORDER SIBLINGS BY bbb.MATCHING_RULE_NAME