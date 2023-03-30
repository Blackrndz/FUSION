/* ************************************************************* --***************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROPERTIES

SELECT (SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.social.selfservice'
	) RES_ENABLE_SOCIAL_CONVERSATION 
	-- Enable social conversations in self-service


--Catalog learning items

,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.course.ss.users'
	) RES_COURSE_ENABLE_CONVERSATION 
	-- Course - Enable conversations for self service users on the catalog page
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.offering.ilt.enrollee'
	) RES_INSTRUCTOR_LED_OFFERING_EN 
	-- Instructor-Led Offering - Enable conversations for active and completed enrollees on the enrollment page
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.offering.blended.enrollee'
	) RES_BLENDED_OFFERING_ENABLE_CO 
	-- Blended Offering - Enable conversations for active and completed enrollees on the enrollment page
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.offering.sp.enrollee'
	) RES_SELF_PACED_OFFERING_ENABLE 
	-- Self-Paced Offering - Enable conversations for active and completed enrollees on the enrollment page
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.specialization.ss.users'
	) RES_SPECIALIZATION_ENABLE_CONV 
	-- Specialization - Enable conversations for self service users on the catalog page
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.specialization.enrollee'
	) RES_SPECIALIZATION_ENABLE_CO_0 
	-- Specialization - Enable conversations for active and completed enrollees on the enrollment page
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.community.catalog.ss.users'
	) RES_LEARNING_COMMUNITY_ENABLE_ 
	-- Learning Community - Enable conversations for self service users on the catalog page


-- Self Service Learning Items

,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.ss.learningitem.ss.users'
	) RES_ENABLE_CONVERSATIONS_FOR_S 
	-- Enable conversations for self service users on video and learning journey
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.community.ss.users'
	) RES_ENABLE_CONVERSATIONS_FOR_1 
	-- Enable conversations for self service users on learning communities
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'forums.community.ss.manager'
	) RES_ENABLE_CONVERSATIONS_FOR_M 
	-- Enable conversations for managers on learning communities

,setupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setupsE0.CREATED_BY  RSC_CREATED_BY
,setupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE 
	,ROW_NUMBER() OVER (ORDER BY LAST_UPDATE_DATE DESC) R1
	FROM WLF_PROPERTIES 
	) setupsE0
WHERE R1 = 1