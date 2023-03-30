/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 SELECT xleENTITYPROFILES.NAME RES_LEGAL_ENTITY_NAME
,xleENTITYPROFILES.LEGAL_ENTITY_IDENTIFIER RES_LEGAL_ENTITY_IDENTIFIER
,hzPATIESE0.PARTY_NAME RES_CONTACT_NAME
,hzORGCONTACTE0.CONTACT_NUMBER RES_CONTACT_NUMBER
,DECODE(hzORGCONTACTROLE0.PRIMARY_CONTACT_PER_ROLE_TYPE ,'Y','Yes','N','No') RES_PRIMARY_RESPONSIBILITY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CONTACT_ROLE_TYPE'
	AND LOOKUP_CODE = hzORGCONTACTROLE0.ROLE_TYPE 
	) RES_RESPONSIBILITY

,hzORGCONTACTROLE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,hzORGCONTACTROLE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,hzORGCONTACTROLE0.CREATED_BY  RSC_CREATED_BY
,hzORGCONTACTROLE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   

FROM FUSION.XLE_ENTITY_PROFILES xleENTITYPROFILES 
,HZ_RELATIONSHIPS hzRELATIONE0 
,HZ_ORG_CONTACTS hzORGCONTACTE0
,HZ_PARTIES hzPATIESE0
,HZ_ORG_CONTACT_ROLES hzORGCONTACTROLE0

WHERE xleENTITYPROFILES.PARTY_ID = hzRELATIONE0.OBJECT_ID
AND hzRELATIONE0.RELATIONSHIP_ID = hzORGCONTACTE0.PARTY_RELATIONSHIP_ID
AND hzRELATIONE0.SUBJECT_ID = hzPATIESE0.PARTY_ID
AND hzORGCONTACTE0.ORG_CONTACT_ID  = hzORGCONTACTROLE0.ORG_CONTACT_ID 
ORDER BY xleENTITYPROFILES.NAME,hzPATIESE0.PARTY_NAME
 