/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT PartyPEO.PARTY_NAME RES_RESOURCE_NAME
,TO_CHAR(ResourceEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_EFFECTIVE_AS_OF_DATE
,PartyPEO.PARTY_NUMBER RES_REGISTRY_ID
,ResourceEO.TIMEZONE_CODE RES_TIME_ZONE
,DECODE(TO_CHAR(ResourceEO.END_DATE_ACTIVE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(ResourceEO.END_DATE_ACTIVE,'DD-Mon-YYYY')) RES_TO_DATE
,ResourceEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ResourceEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ResourceEO.CREATED_BY RSC_CREATED_BY
,ResourceEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_RESOURCE_PROFILES ResourceEO
,HZ_PARTIES PartyPEO
,PER_ALL_PEOPLE_F PersonDPEONQ1
,HZ_ORIG_SYS_REFERENCES OrigSysRefPEONQ1
WHERE ResourceEO.PARTY_ID = PartyPEO.PARTY_ID
AND TO_CHAR(PersonDPEONQ1.PERSON_ID)         = OrigSysRefPEONQ1.ORIG_SYSTEM_REFERENCE
AND ResourceEO.PARTY_ID                      = OrigSysRefPEONQ1.OWNER_TABLE_ID
AND(SYSDATE BETWEEN PersonDPEONQ1.EFFECTIVE_START_DATE AND PersonDPEONQ1.EFFECTIVE_END_DATE)
ORDER BY RES_RESOURCE_NAME
,RES_EFFECTIVE_AS_OF_DATE