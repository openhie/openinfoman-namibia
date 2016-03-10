declare namespace csd = 'urn:ihe:iti:csd:2013';
declare variable $careServicesRequest as item() external;

<html>
 <body>
  <ul>
   <li>You have {count(/csd:CSD/csd:providerDirectory/*)} providers.</li>
   <li>You have {count(/csd:CSD/csd:facilityDirectory/*)} facilities.</li>
   <li>You have {count(/csd:CSD/csd:organizationDirectory/*)} organizations.</li>
   <li>You have {count(/csd:CSD/csd:serviceDirectory/*)} services.</li>
  </ul>
  <table>
  {(: Looping through the Facility directory :)
    for $facility in /csd:CSD/csd:facilityDirectory/*
      let $facilityName:=$facility/csd:primaryName
      order by $facilityName
      return
	  <span>
	  <h2>Facility List</h2>
      <tr>
        <td> {string($facility/csd:record/@sourceDirectory)}</td>
        <td>{ $facilityName }</td> 
        <td>{ string($facility/@urn)}</td>	 
      </tr>
	  </span>
	  <span>
	  <h2>Empoloyee's List</h2>
	  <h3>{$facilityName}</h3>
	     <table> 
		 {
           for $provider in /csd:CSD/csd:providerDirectory/*
             let $EmpoloyeeName:= $provider/demogrpahic/csd:name[1]/csd:forename
             let $pfacility:=$provider/csd:facilities/facility/@entityID
			 let $gender_code:= $provider/demogrpahic/csd:gender
			 let $DOB:= $provider/demogrpahic/csd:dateOfBirth
			 let $email:= string($provider/demogrpahic/csd:contactPoint/@EMAIL)
             where $facility/@urn = $pfacility
             order by $EmpoloyeeName
			 return
			 <tr>
			  <td>{$EmpoloyeeName}</td>
			  <td>{$gender_code}</td>
			  <td>{$DOB}</td>
			  <td>{$email}</td>
			 </tr>
			 }
		   </table>
	  </span>
  
  }
  </table>
 </body>
</html>
