//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace football13.DataModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class Game
    {
        public Game()
        {
            this.MnfPicks = new HashSet<MnfPick>();
            this.Picks = new HashSet<Pick>();
        }
    
        public int Id { get; set; }
        public int Week { get; set; }
        public System.DateTime GameDate { get; set; }
        public int VisId { get; set; }
        public int HomeId { get; set; }
        public Nullable<int> Favorite { get; set; }
        public Nullable<double> Spread { get; set; }
        public Nullable<int> HomeScore { get; set; }
        public Nullable<int> AwayScore { get; set; }
        public bool MNFDiscriminator { get; set; }
    
        public virtual ICollection<MnfPick> MnfPicks { get; set; }
        public virtual ICollection<Pick> Picks { get; set; }
        public virtual Team VisTeam { get; set; }
        public virtual Team HomeTeam { get; set; }
    }
}