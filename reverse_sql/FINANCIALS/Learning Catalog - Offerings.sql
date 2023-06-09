/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_LEARNING_ITEMS_F

WITH EVAL AS (SELECT MANDATORY_FLAG
	,TYPE_OF_USAGE
	,SOURCE_ID
	FROM WLF_LI_RELATIONS_F
	WHERE SOURCE_TYPE = 'ORA_HRQ_QSTNR'
	AND LEARNING_ITEM_ID = -1
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	)
,QUESTIONNAIRE AS (SELECT NAME
	,QUESTIONNAIRE_ID
	,ROW_NUMBER() OVER (PARTITION BY QUESTIONNAIRE_ID ORDER BY QUESTIONNAIRE_ID,QSTNR_VERSION_NUM DESC) R1
	FROM HRQ_QUESTIONNAIRES_TL
	WHERE LANGUAGE = USERENV('LANG'))


SELECT learningTlE0.NAME RES_OFFERING_TITLE
,learningE0.LEARNING_ITEM_NUMBER RES_OFFERING_NUMBER
,TO_CHAR(learningE0.START_DATE,'DD-Mon-YYYY') RES_PUBLISH_START_DATE
,DECODE(TO_CHAR(learningE0.END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(learningE0.END_DATE ,'DD-Mon-YYYY')) RES_PUBLISH_END_DATE
,(SELECT NAME
	FROM WLF_LEARNING_ITEMS_F_VL
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND LEARNING_ITEM_ID = learningDtlsE0.COURSE_LEARNING_ITEM_ID
	) RES_COURSE_TITLE

,learningTlE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_LEARN_DELIVERY_MODE'
    AND LOOKUP_CODE = learningDtlsE0.DELIVERY_MODE
	) RES_OFFERING_TYPE


-- Offering Details

,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_CLASSROOM_TYPE'
    AND LOOKUP_CODE = learningDtlsE0.PRIMARY_CLASSROOM_TYPE
	) RES_PRIMARY_CLASSROOM
,(SELECT DESCRIPTION
    FROM FND_LANGUAGES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LANGUAGE_CODE = learningE0.LANGUAGE_CODE
    ) RES_LANGUAGE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_BOOKING_TYPE'
    AND LOOKUP_CODE = learningDtlsE0.FACILITATOR_TYPE
	) RES_FACILITATOR_TYPE
,(SELECT DISPLAY_NAME
	FROM PER_PERSON_NAMES_F
	WHERE NAME_TYPE = 'GLOBAL'
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND PERSON_ID = (SELECT PERSON_ID
		FROM WLF_INSTRUCTOR_RESOURCES
		WHERE INSTRUCTOR_ID = learningDtlsE0.PRIMARY_INSTRUCTOR_ID)
	) RES_PRIMARY_INSTRUCTOR
,(SELECT DISPLAY_NAME
	FROM PER_PERSON_NAMES_F
	WHERE NAME_TYPE = 'GLOBAL'
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND PERSON_ID = learningDtlsE0.COORDINATOR_ID
	) RES_OFFERING_COORDINATOR


-- Capacity Rules

,DECODE(learningDtlsE0.ENABLE_CAPACITY,'Y','Yes','No') RES_CAPACITY_RULES
,learningDtlsE0.MINIMUM_ATTENDEES RES_MINIMUM_CAPACITY
,learningDtlsE0.MAXIMUM_ATTENDEES RES_MAXIMUM_CAPACITY
,DECODE(learningDtlsE0.ENABLE_WAITLIST,'Y','Yes','No') RES_ALLOW_JOINING_THE_WAITLIST -- Allow joining the waitlist from self-service


-- Pricing

,DECODE(pricingE0.PRICING_RULE_ID,NULL,'No','Yes') RES_OVERRIDE_PRICING
,pricingE0.CURRENCY RES_CURRENCY


-- Payment

,DECODE(learningE0.PAYMENT_RULE_ID,NULL,'No','Yes') RES_OVERRIDE_PAYMENT_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_PAYMENT_PROCESSING'
    AND LOOKUP_CODE = paymentsE0.PAYMENT_TYPE 
	) RES_PAYMENT_TYPE


,TO_CHAR(learningE0.LI_START_DATE,'DD-Mon-YYYY') RES_OFFERING_START_DATE
,TO_CHAR(learningE0.LI_END_DATE,'DD-Mon-YYYY') RES_OFFERING_END_DATE


-- Evaluations

,DECODE(activitiesE0.PARENT_LEARNING_ITEM_ID,NULL,'No','Yes') RES_ENABLE_EVALUATION
,(CASE
	WHEN activitiesE0.RELATED_CONTENT_ID = -1 THEN
		'Yes'
	ELSE
		'No'
	END) RES_USE_DEFAULT_EVALUATION
,(CASE
	WHEN activitiesE0.RELATED_CONTENT_ID = -1 THEN
		'No'
	ELSE
		'Yes'
	END) RES_USE_ANOTHER_EVALUATION
,(CASE
	WHEN activitiesE0.RELATED_CONTENT_ID = -1 THEN
		(SELECT NAME
			FROM QUESTIONNAIRE
			WHERE R1 = 1
			AND QUESTIONNAIRE_ID = (SELECT SOURCE_ID
				FROM EVAL
				WHERE TYPE_OF_USAGE = 'ORA_BLENDED'))
	ELSE
		(SELECT NAME
			FROM QUESTIONNAIRE
			WHERE R1 = 1
			AND QUESTIONNAIRE_ID = activitiesE0.RELATED_CONTENT_ID)
	END) RES_EVALUATION
,(SELECT LEARNING_ITEM_NUMBER
	FROM WLF_LEARNING_ITEMS_F
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND LEARNING_ITEM_ID = activitiesE0.LEARNING_ITEM_ID
	) RES_ACTIVITY_NUMBER
,(CASE
	WHEN activitiesE0.RELATED_CONTENT_ID = -1 THEN
		(SELECT DECODE(MANDATORY_FLAG,'Y','Yes','No')
			FROM EVAL
			WHERE TYPE_OF_USAGE = 'ORA_BLENDED')
	ELSE
		DECODE(activitiesE0.COMPLETION_TYPE,'ORA_REQUIRED','Yes','No')
	END) RES_REQUIRED_FOR_COMPLETION
,learningE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,learningE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,learningE0.CREATED_BY  RSC_CREATED_BY
,learningE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WLF_LEARNING_ITEMS_F_TL learningTlE0
,WLF_LEARNING_ITEMS_F learningE0
,WLF_LI_CLASSES_F learningDtlsE0

,(SELECT * 
	FROM WLF_PRICING_RULES_F 
	WHERE USAGE = 'ORA_CLASS'
	) pricingE0
,WLF_PAYMENT_RULES_F paymentsE0

,(SELECT * 
	FROM WLF_LI_ACTIVITIES_F 
	WHERE ACTIVITY_TYPE = 'ORA_DEF_QUESTIONNAIRE'
	) activitiesE0

WHERE learningE0.LEARNING_ITEM_TYPE = 'ORA_CLASS'
AND SYSDATE BETWEEN learningE0.EFFECTIVE_START_DATE AND learningE0.EFFECTIVE_END_DATE

AND learningE0.LEARNING_ITEM_ID = learningTlE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_START_DATE = learningTlE0.EFFECTIVE_START_DATE
AND learningTlE0.LANGUAGE = USERENV('LANG')

AND learningE0.LEARNING_ITEM_ID = learningDtlsE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_END_DATE BETWEEN learningDtlsE0.EFFECTIVE_START_DATE AND learningDtlsE0.EFFECTIVE_END_DATE

AND learningE0.PRICING_RULE_ID = pricingE0.PRICING_RULE_ID(+)
AND learningE0.PAYMENT_RULE_ID = paymentsE0.PAYMENT_RULE_ID(+)
AND learningE0.LEARNING_ITEM_ID = activitiesE0.PARENT_LEARNING_ITEM_ID(+)

ORDER BY learningE0.LEARNING_ITEM_NUMBER