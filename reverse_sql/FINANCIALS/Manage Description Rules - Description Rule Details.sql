/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Description%20Rules%20-%20Description%20Rule%20Details.sql $:
 * $Id: Manage Description Rules - Description Rule Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
WITH RULES AS (SELECT DESCRIPTION_PRIO_ID
	,APPLICATION_ID
	,AMB_CONTEXT_CODE
	,DESCRIPTION_TYPE_CODE
	,DESCRIPTION_CODE
	,ROW_NUMBER() OVER (PARTITION BY APPLICATION_ID	,AMB_CONTEXT_CODE ,DESCRIPTION_TYPE_CODE ,DESCRIPTION_CODE
		ORDER BY USER_SEQUENCE) SEQ1
	,LAST_UPDATED_BY	
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	FROM XLA_DESC_PRIORITIES)
	
/*,PREP_RULE_DTLS AS (SELECT dtlsE0.DESCRIPTION_PRIO_ID
	,ROW_NUMBER() OVER (PARTITION BY dtlsE0.DESCRIPTION_PRIO_ID ORDER BY dtlsE0.USER_SEQUENCE) SEQ1
	,dtlsE0.VALUE_TYPE_CODE
	,dtlsE0.LITERAL
	,SourceE0.NAME S_NAME
	FROM XLA_DESCRIPT_DETAILS_VL dtlsE0
	,XLA_SOURCES_VL SourceE0
	WHERE dtlsE0.SOURCE_APPLICATION_ID = SourceE0.APPLICATION_ID(+)
	AND dtlsE0.SOURCE_TYPE_CODE = SourceE0.SOURCE_TYPE_CODE(+)
	AND dtlsE0.SOURCE_CODE = SourceE0.SOURCE_CODE(+))*/
	
,RULE_DTLS AS (SELECT DESCRIPTION_PRIO_ID
	,SEQ1
	,(CASE 
		WHEN VALUE_TYPE_CODE = 'L' THEN 
			''||LITERAL||' '
		ELSE
			'"'||S_NAME||'" '	
		END) RULE_STMT
	FROM (SELECT dtlsE0.DESCRIPTION_PRIO_ID
		,ROW_NUMBER() OVER (PARTITION BY dtlsE0.DESCRIPTION_PRIO_ID ORDER BY dtlsE0.USER_SEQUENCE) SEQ1
		,dtlsE0.VALUE_TYPE_CODE
		,dtlsE0.LITERAL
		,SourceE0.NAME||
		(CASE
			WHEN ((SELECT COUNT(*) CNT FROM XLA_SOURCES_VL WHERE SOURCE_CODE = dtlsE0.SOURCE_CODE) > 1 OR (SELECT COUNT(*) CNT FROM XLA_SOURCES_VL WHERE NAME = SourceE0.NAME) > 1) THEN
				'('||NVL((SELECT APPLICATION_SHORT_NAME FROM FND_APPLICATION WHERE APPLICATION_ID = dtlsE0.SOURCE_APPLICATION_ID)
					,(SELECT APPLICATION_NAME FROM XLA_SUBLEDGERS_TL WHERE LANGUAGE = USERENV('LANG') AND APPLICATION_ID = dtlsE0.SOURCE_APPLICATION_ID))||
				','||(SELECT MEANING 
					FROM FND_LOOKUP_VALUES
					WHERE LANGUAGE = USERENV('LANG')
					AND LOOKUP_TYPE = 'XLA_SOURCE_TYPE'
					AND LOOKUP_CODE = dtlsE0.SOURCE_TYPE_CODE)||')'
			END) S_NAME
		FROM XLA_DESCRIPT_DETAILS_VL dtlsE0
		,XLA_SOURCES_VL SourceE0
		WHERE dtlsE0.SOURCE_APPLICATION_ID = SourceE0.APPLICATION_ID(+)
		AND dtlsE0.SOURCE_TYPE_CODE = SourceE0.SOURCE_TYPE_CODE(+)
		AND dtlsE0.SOURCE_CODE = SourceE0.SOURCE_CODE(+))
	)
	
,STATEMENT_CONCAT AS
	(SELECT ' '||BRACKET_LEFT_CODE||' "'
	||NAME||'"'||(CASE
		WHEN KEY_FLEXFIELD_FLAG = 'Y' THEN
			(CASE
				WHEN FLEXFIELD_SEGMENT_CODE IS NULL THEN
					'."All"'
				ELSE
					'."'||(SELECT NAME FROM FND_KF_SEGMENT_LABELS_VL
						WHERE APPLICATION_ID = XX.FLEXFIELD_APPLICATION_ID
						AND KEY_FLEXFIELD_CODE = XX.ID_FLEX_CODE
						AND SEGMENT_LABEL_CODE = XX.FLEXFIELD_SEGMENT_CODE)||'"'
			END)
		WHEN (SELECT COUNT(*) CNT FROM XLA_SOURCES_VL WHERE SOURCE_CODE = XX.SOURCE_CODE) > 1 THEN
			'('||(SELECT APPLICATION_SHORT_NAME FROM FND_APPLICATION_VL WHERE APPLICATION_ID = XX.APPLICATION_ID)||') '
		END)
	||' '||DECODE(LINE_OPERATOR_CODE,'E','=','D','!=','N','Is null','X','is not null','G','>','H','>=','L','<','M','<=')||' '||
	(CASE
		WHEN XX.LOOKUP_TYPE IS NOT NULL THEN
			(SELECT MEANING
				FROM FND_LOOKUP_VALUES
				WHERE LOOKUP_TYPE = XX.LOOKUP_TYPE
				AND LOOKUP_CODE = XX.VALUE_CONSTANT
				AND VIEW_APPLICATION_ID = XX.VIEW_APPLICATION_ID
				AND LANGUAGE = USERENV('LANG'))
		ELSE 
			VALUE_CONSTANT
		END)||' '||BRACKET_RIGHT_CODE||' '||DECODE(LOGICAL_OPERATOR_CODE,'A','''AND''','O','''Or''') CONTEXT
	,CON_APP_ID
	,AMB_CONTEXT_CODE
	,ENTITY_CODE
	,EVENT_CLASS_CODE
	,ACCOUNTING_LINE_TYPE_CODE
	,ACCOUNTING_LINE_CODE
	,SEQ1
	,DESCRIPTION_PRIO_ID
	FROM (SELECT ConditionEO.SEGMENT_RULE_DETAIL_ID
		,ConditionEO.USER_SEQUENCE
		,ConditionEO.BRACKET_LEFT_CODE
		,ConditionEO.BRACKET_RIGHT_CODE
		,ConditionEO.VALUE_TYPE_CODE
		,SourceE0.NAME
		,SourceE0.SOURCE_CODE
		,SourceE0.KEY_FLEXFIELD_FLAG
		,SourceE0.APPLICATION_ID
		,ROW_NUMBER() OVER (PARTITION BY DESCRIPTION_PRIO_ID ORDER BY USER_SEQUENCE) SEQ1
		,ConditionEO.VALUE_CONSTANT
		,ConditionEO.LINE_OPERATOR_CODE
		,ConditionEO.LOGICAL_OPERATOR_CODE
		,ConditionEO.FLEXFIELD_SEGMENT_CODE
		,SourceE0.FLEXFIELD_APPLICATION_ID
		,SourceE0.ID_FLEX_CODE
		,ConditionEO.APPLICATION_ID CON_APP_ID
		,ConditionEO.AMB_CONTEXT_CODE
		,ConditionEO.ENTITY_CODE
		,ConditionEO.EVENT_CLASS_CODE
		,ConditionEO.ACCOUNTING_LINE_TYPE_CODE
		,ConditionEO.ACCOUNTING_LINE_CODE
		,SourceE0.LOOKUP_TYPE
		,SourceE0.VIEW_APPLICATION_ID
		,ConditionEO.DESCRIPTION_PRIO_ID
		FROM XLA_CONDITIONS ConditionEO
		,XLA_SOURCES_VL SourceE0
		WHERE SourceE0.APPLICATION_ID = ConditionEO.APPLICATION_ID
		AND SourceE0.SOURCE_TYPE_CODE = ConditionEO.SOURCE_TYPE_CODE
		AND SourceE0.SOURCE_CODE = ConditionEO.SOURCE_CODE) XX
	WHERE SEQ1 BETWEEN 1 AND 35
	AND DESCRIPTION_PRIO_ID IS NOT NULL)
	

SELECT (SELECT APPLICATION_NAME
	FROM XLA_SUBLEDGERS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND APPLICATION_ID = descRulesE0.APPLICATION_ID
	) RES_SUBLEDGER_APPLICATION
,descRulesE0.NAME RES_NAME
,descRulesE0.DESCRIPTION_CODE RES_SHORT_NAME
,rulesE0.SEQ1 RES_PRIORITY

,(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 1)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 2) 
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 3) 
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 4)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 5)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 6)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 7)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 8)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 9)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 10)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 11)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 12)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 13)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 14)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 15)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 16)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 17)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 18)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 19)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 20)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 21)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 22)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 23)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 24)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 25)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 26)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 27)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 28)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 29)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 30)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 31)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 32)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 33)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 34)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 35)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 36)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 37)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 38)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 39)
	||(SELECT RULE_STMT FROM RULE_DTLS WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 40)
	RES_DESCRIPTION_DETAILS

,(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 1)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 2)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 3)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 4)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 5)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 6)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 7)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 8)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 9)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 10)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 11)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 12)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 13)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 14)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 15)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 16)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 17)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 18)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 19)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 20)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 21)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 22)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 23)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 24)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 25)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 26)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 27)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 28)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 29)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 30)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 31)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 32)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 33)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 34)
	||(SELECT CONTEXT FROM STATEMENT_CONCAT WHERE DESCRIPTION_PRIO_ID = rulesE0.DESCRIPTION_PRIO_ID AND SEQ1 = 35)
	RES_CONDITIONS

,descRulesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,descRulesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,descRulesE0.CREATED_BY  RSC_CREATED_BY
,descRulesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_DESCRIPTIONS_VL descRulesE0
,RULES rulesE0
WHERE descRulesE0.APPLICATION_ID = rulesE0.APPLICATION_ID
AND descRulesE0.AMB_CONTEXT_CODE = rulesE0.AMB_CONTEXT_CODE
AND descRulesE0.DESCRIPTION_TYPE_CODE = rulesE0.DESCRIPTION_TYPE_CODE
AND descRulesE0.DESCRIPTION_CODE = rulesE0.DESCRIPTION_CODE
ORDER BY 1,2,3,4