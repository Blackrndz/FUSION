/* ****************************************************************************
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
	WHERE NAME = 'ALERT_ENABLE_PEER_RECOMMEND'
	) RES_ENABLE_ALERTS_FOR_RECOMMEN 
	-- Enable alerts for recommended learning items created in self-service
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_SPECIALIST_RECOMMEND'
	) RES_ENABLE_ALERTS_FOR_RECOMM_0 
	-- Enable alerts for recommended learning items created by learning administrators
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_UPDATES_CLASS_ACTIVITY'
	) RES_ENABLE_ALERTS_TO_ASSIGNEES 
	-- Enable alerts to assignees for classroom changes
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_UPDATES_DATE_ACTIVITY'
	) RES_ENABLE_ALERTS_TO_ASSIGNE_1 
	-- Enable alerts to assignees for changes to activity dates
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_ILT_REMINDER1'
	) RES_DAYS_BEFORE_THE_START_OF_T 
	-- Days before the start of training to send instructors an alert reminder
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_ACTIVITY_CHANGE_INSTRUCTOR'
	) RES_ENABLE_ALERTS_TO_INSTRUCTO 
	-- Enable alerts to instructors when instructor-led activities change
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_ADD_REMOVE_ACTIVITY'
	) RES_ENABLE_ALERTS_TO_ASSIGNE_2 
	-- Enable alerts to assignees for added or removed activities
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_DEFAULT_CALENDAR_ORGANIZER'
	) RES_DEFAULT_ORGANIZER_FOR_CALE 
	-- Default Organizer for Calendar Meeting Invites
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'ALERT_ENABLE_USE_PRIMARY_OFFERING_COORDINATOR'
	) RES_WHEN_AVAILABLE_USE_PRIMARY 
	-- When Available, Use Primary Offering Coordinator as the Organizer for Calendar Meeting Invites
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